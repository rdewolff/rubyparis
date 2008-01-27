class VentraineursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @ventraineur_pages, @ventraineurs = paginate :ventraineurs, :per_page => 10
  end

  def show
    @ventraineur = Ventraineur.find(params[:id])
  end

  def new
    @ventraineur = Ventraineur.new
  end

  def create
    @ventraineur = Ventraineur.new(params[:ventraineur])
    
    @personne = Personne.new(:nom => @ventraineur.nom, :prenom => @ventraineur.prenom)
    @sportif = Sportif.new(:dateNaissance => @ventraineur.dateNaissance,
      :taille => @ventraineur.taille,:pays => @ventraineur.pays)
    @entraineur = Entraineur.new
    
    if @personne.save
      @sportif.id = @personne.id
      @entraineur.id = @sportif.id
      
      if @sportif.save && @entraineur.save
        flash[:notice] = 'Entraineur was successfully created.'
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
    @ventraineur = Ventraineur.find(params[:id])
  end

  def update
    @ventraineur = Ventraineur.new(params[:ventraineur])
    
    @personne = Personne.find(params[:id])
    @sportif = Sportif.find(params[:id])
    
    if @personne.update_attributes(:nom => @ventraineur.nom,:prenom => @ventraineur.prenom) &&
        @sportif.update_attributes(:dateNaissance => @ventraineur.dateNaissance,
          :taille => @ventraineur.taille,:pays => @ventraineur.pays)
      flash[:notice] = 'Ventraineur was successfully updated.'
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
