class VadministrateursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @vadministrateur_pages, @vadministrateurs = paginate :vadministrateurs, :per_page => 10
  end

  def show
    @vadministrateur = Vadministrateur.find(params[:id])
  end

  def new
    @vadministrateur = Vadministrateur.new
  end

  def create
    
    @vadministrateur = Vadministrateur.new(params[:vadministrateur])
    
    @personne = Personne.new(:nom => @vadministrateur.nom, :prenom => @vadministrateur.prenom)
    @utilisateur = Utilisateur.new(:login => @vadministrateur.login,
      :password => @vadministrateur.password, :email => @vadministrateur.email)
    @administrateur = Administrateur.new
    
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
    @vadministrateur = Vadministrateur.find(params[:id])
  end

  def update
    @vadministrateur = Vadministrateur.new(params[:vadministrateur])
    @personne = Personne.find(params[:id])
    @utilisateur = Utilisateur.find(params[:id])
    
    if @personne.update_attributes(:nom => @vadministrateur.nom,:prenom => @vadministrateur.prenom) &&
        @utilisateur.update_attributes(:login => @vadministrateur.login,
          :email => @vadministrateur.email)
      flash[:notice] = 'Administrateur was successfully updated.'
      redirect_to :action => 'show', :id => @personne.id
    else
      render :action => 'edit'
    end
  end

  def destroy
    Personne.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
