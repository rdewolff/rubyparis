class MatchsController < ApplicationController
  
  before_filter :load_data
  
  GroupeOption = Struct.new(:id, :name)
  class GroupeType 
    attr_reader :type_name, :options
    
    def initialize(name)
      @type_name = name
      @options = []
    end
    
    def <<(option)
      @options << option
    end
  end
  
  
  
  def load_data
    groupe_options = []
    
    @compet = Competition.find(:all, :order => "nom asc")
    
    for compet in @compet
      tmp = GroupeType.new(compet.nom)
      
      @group = Groupe.find :all, :conditions => ["competition_id = ?",compet.id], :order => "nom asc"
      
      for gp in @group
        tmp << GroupeOption.new(gp.id, gp.nom) 
      end
      groupe_options << tmp
    end
    return groupe_options
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @match_pages, @matchs = paginate :matchs, :per_page => 10
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @maVar = load_data
    @match = Match.new
  end
  
  def create
    @match = Match.new(params[:match])
    if @match.save
      flash[:notice] = "Le match '" + @match.equipea.nom + " vs " + @match.equipeb.nom + "' a été créé avec succès."
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @maVar = load_data
    @match = Match.find(params[:id])
  end

  def update
    
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      flash[:notice] = "Le match '" + @match.equipea.nom + " vs " + @match.equipeb.nom + "' a été modifié avec succès."
      redirect_to :action => 'show', :id => @match
    else
      render :action => 'edit'
    end
  end
  
  # selectionne les prochains match
  def prochains_matchs
    @match_pages, @matchs = paginate :matchs, :per_page => 5
    render( :layout => false) # n'affiche pas le layout
  end
  
  # selectionne les matchs terminé 
  def resultats
    @matchs = Match.find(:all, :conditions => ["date < ?", Date.today])
  end
  
  def update_resultats
    @match = Match.find(params[:id])
    if @match.update_attributes(params[:match])
      flash[:notice] = "Le score du match '" + @match.equipea.nom + " vs " + @match.equipeb.nom + "' a été ajouté avec succès."
      redirect_to :action => 'show', :id => @match
    else
      render :action => 'resultats'
    end
  end
  
  
  def destroy
    Match.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
