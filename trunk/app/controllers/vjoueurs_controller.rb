class VjoueursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @vjoueur_pages, @vjoueurs = paginate :vjoueurs, :per_page => 10
  end

  def show
    @vjoueur = Vjoueur.find(params[:id])
  end

  def new
    @vjoueur = Vjoueur.new
  end

  def create
    @vjoueur = Vjoueur.new(params[:vjoueur])
    
    @personne = Personne.new(:nom => @vjoueur.nom, :prenom => @vjoueur.prenom)
    @sportif = Sportif.new(:dateNaissance => @vjoueur.dateNaissance,
      :taille => @vjoueur.taille,:pays => @vjoueur.pays)
    @joueur = Joueur.new(:position_id => @vjoueur.position,
      :club => @vjoueur.club, :selection => params[:selection] == "oui")
    
    if @personne.save
      @sportif.id = @personne.id
      @joueur.id = @sportif.id
      
      if @sportif.save && @joueur.save
        flash[:notice] = 'Joueur was successfully created.'
        redirect_to :action => 'list'
      else
        Personne.delete(@personne.id)
        render :action => 'new'
      end
      
    else
      render :action => 'new'
    end
  end

  def edit
    @vjoueur = Vjoueur.find(params[:id])
  end

  def update
    @vjoueur = Vjoueur.new(params[:vjoueur])
    
    @personne = Personne.find(params[:id])
    @sportif = Sportif.find(params[:id])
    
    if @personne.update_attributes(:nom => @vjoueur.nom,:prenom => @vjoueur.prenom) &&
        @sportif.update_attributes(:dateNaissance => @vjoueur.dateNaissance,
          :taille => @vjoueur.taille,:pays => @vjoueur.pays)
      flash[:notice] = 'Joueur was successfully updated.'
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
