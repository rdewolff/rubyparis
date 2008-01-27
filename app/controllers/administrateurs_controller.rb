class AdministrateursController < ApplicationController
  before_filter :authenticate
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @administrateur_pages, @administrateurs = paginate :administrateurs, :per_page => 10
  end

  def show
    @administrateur = Administrateur.find(params[:id])
  end

  def new
    @administrateur = Administrateur.new
  end

  def create
    @personne = Personne.new(params[:personnes])
    @utilisateur = Utilisateur.new(params[:utilisateurs])
    @administrateur = Administrateur.new(params[:administrateurs])
    
    if @personne.save
      @utilisateur.id = @personne.id
      @administrateur.id = @utilisateur.id
      
      @hashpw = Hashpw.new
      @utilisateur.password = @hashpw.encrypt(@utilisateur.password)
      
      if @utilisateur.save && @administrateur.save
        flash[:notice] = 'Administrateur was successfully created.'
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
    @administrateur = Administrateur.find(params[:id])
  end

  def update
    @administrateur = Administrateur.find(params[:id])
    if @administrateur.update_attributes(params[:administrateur])
      flash[:notice] = 'Administrateur was successfully updated.'
      redirect_to :action => 'show', :id => @administrateur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Administrateur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
