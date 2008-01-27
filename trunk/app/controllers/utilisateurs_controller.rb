class UtilisateursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @utilisateur_pages, @utilisateurs = paginate :utilisateurs, :per_page => 10
  end

  def show
    @utilisateur = Utilisateur.find(params[:id])
  end

  def new
    @utilisateur = Utilisateur.new
  end

  def create
    @utilisateur = Utilisateur.new(params[:utilisateur])
    if @utilisateur.save
      flash[:notice] = 'Utilisateur was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @utilisateur = Utilisateur.find(params[:id])
  end

  def update
    @utilisateur = Utilisateur.find(params[:id])
    if @utilisateur.update_attributes(params[:utilisateur])
      flash[:notice] = 'Utilisateur was successfully updated.'
      redirect_to :action => 'show', :id => @utilisateur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Utilisateur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
