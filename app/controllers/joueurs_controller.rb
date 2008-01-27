class JoueursController < ApplicationController
  before_filter :load_Sorted
  
  def load_Sorted
    @nations = Nation.find :all, :order=>"pays asc"
    @clubs = Equipe.find :all, :conditions => "selection = 0", :order => "nom asc"
    @selections = Equipe.find :all, :conditions => "selection = 1", :order => "nom asc"
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @joueur_pages, @joueurs = paginate :joueurs, :per_page => 10
  end

  def show
    @joueur = Joueur.find(params[:id])
  end

  def new
    @joueur = Joueur.new
  end

  def create
    @personne = Personne.new(params[:personnes])
    @sportif = Sportif.new(params[:sportifs])
    @joueur = Joueur.new(params[:joueur])
    
    if @personne.save
      @sportif.id = @personne.id
      @joueur.id = @sportif.id
      
      if @sportif.save && @joueur.save
        flash[:notice] = 'Joueur was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
        
        Personne.delete(@personne.id)
      end
      
    else
      render :action => 'new'
    end
  end

  def edit
    @joueur = Joueur.find(params[:id])
  end

  def update
    @joueur = Joueur.find(params[:id])
    if @joueur.update_attributes(params[:joueur])
      flash[:notice] = 'Joueur was successfully updated.'
      redirect_to :action => 'show', :id => @joueur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Joueur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
