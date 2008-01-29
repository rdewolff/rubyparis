class EquipesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @equipe_pages, @equipes = paginate :equipes, :per_page => 10
  end

  def show
    @equipe = Equipe.find(params[:id])
  end

  def new
    @equipe = Equipe.new
  end

  def create
    @equipe = Equipe.new(params[:equipe])
    if @equipe.save
      flash[:notice] = "L'équipe '" + @equipe.nom + "' a été créé avec succès!"
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @equipe = Equipe.find(params[:id])
  end

  def update
    @equipe = Equipe.find(params[:id])
    if @equipe.update_attributes(params[:equipe])
      flash[:notice] = "L'équipe '" + @equipe.nom + "' a été mise à jour avec succès!"
      redirect_to :action => 'show', :id => @equipe
    else
      render :action => 'edit'
    end
  end

  
  def destroy
    Equipe.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  # effichage d'equipe en fonction du nom
  def eq
    @equipe = Equipe.find(:all, :conditions => "nom LIKE '%#{params[:eq]}%'")
    @ventraineur = Ventraineur.find(:all, :conditions => "id='%#{@equipe[0].entraineur_id}%'")
  end
  
  
end
