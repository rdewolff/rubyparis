class VarbitresController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @varbitre_pages, @varbitres = paginate :varbitres, :per_page => 10
  end

  def show
    @varbitre = Varbitre.find(params[:id])
  end

  def new
    @varbitre = Varbitre.new
  end

  def create
    @varbitre = Varbitre.new(params[:varbitre])
    
    @personne = Personne.new(:nom => @varbitre.nom, :prenom => @varbitre.prenom)
    @sportif = Sportif.new(:dateNaissance => @varbitre.dateNaissance,
      :taille => @ventraineur.taille,:pays => @varbitre.pays)
    @arbitre = Arbitre.new
    
    if @personne.save
      @sportif.id = @personne.id
      @varbitre.id = @sportif.id
      
      if @sportif.save && @varbitre.save
        flash[:notice] = 'Arbitre was successfully created.'
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
    @varbitre = Varbitre.find(params[:id])
  end

  def update
    @varbitre = Varbitre.new(params[:ventraineur])
    
    @personne = Personne.find(params[:id])
    @sportif = Sportif.find(params[:id])
    
    if @personne.update_attributes(:nom => @varbitre.nom,:prenom => @varbitre.prenom) &&
        @sportif.update_attributes(:dateNaissance => @varbitre.dateNaissance,
          :taille => @varbitre.taille,:pays => @varbitre.pays)
      flash[:notice] = 'Arbitre was successfully updated.'
      redirect_to :action => 'show', :id => @personne.id
    else
      render :action => 'edit'
    end
  end

  def destroy
    Varbitre.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
