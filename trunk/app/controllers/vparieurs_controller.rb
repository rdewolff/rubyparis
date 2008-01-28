class VparieursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @vparieur_pages, @vparieurs = paginate :vparieurs, :per_page => 10
  end

  def show
    @vparieur = Vparieur.find(params[:id])
  end

  def new
    @vparieur = Vparieur.new
  end

  def create
    @vparieur = Vparieur.new(params[:vparieur])
    
    @personne = Personne.new(:nom => @vparieur.nom, :prenom => @vparieur.prenom)
    @utilisateur = Utilisateur.new(:login => @vparieur.login,
      :password => @vparieur.password, :email => @vparieur.email)
    @parieur = Parieur.new
    
    if @personne.save
      @utilisateur.id = @personne.id
      @parieur.id = @utilisateur.id
      
      @hashpw = Hashpw.new
      @utilisateur.password = @hashpw.encrypt(@utilisateur.password)
      
      if @utilisateur.save && @parieur.save
        flash[:notice] = 'Parieur was successfully created.'
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
    @vparieur = Vparieur.find(params[:id])
  end

  def update
    @vparieur = Vparieur.new(params[:vparieur])
    @personne = Personne.find(params[:id])
    @utilisateur = Utilisateur.find(params[:id])
    
    if @personne.update_attributes(:nom => @vparieur.nom,:prenom => @vparieur.prenom) &&
        @utilisateur.update_attributes(:login => @vparieur.login,
          :email => @vparieur.email)
      flash[:notice] = 'Parieur was successfully updated.'
      redirect_to :action => 'show', :id => @personne.id
    else
      render :action => 'edit'
    end
  end

  def destroy
    Vparieur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
