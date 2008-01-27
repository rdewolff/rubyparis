class ParieursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @parieur_pages, @parieurs = paginate :parieurs, :per_page => 10
  end

  def show
    @parieur = Parieur.find(params[:id])
  end

  def new
    @parieur = Parieur.new
  end

  def create
    @personne = Personne.new(params[:personnes])
    @utilisateur = Utilisateur.new(params[:utilisateurs])
    @parieur = Parieur.new(params[:parieurs])
    
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
    @parieur = Parieur.find(params[:id])
  end

  def update
    @parieur = Parieur.find(params[:id])
    if @parieur.update_attributes(params[:parieur])
      flash[:notice] = 'Parieur was successfully updated.'
      redirect_to :action => 'show', :id => @parieur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Parieur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
