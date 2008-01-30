class MatchsController < ApplicationController
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
    @match_pages, @matchs = paginate :matchs, :per_page => 10
    render( :layout => false) # n'affiche pas le layout
  end
  
  def destroy
    Match.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
