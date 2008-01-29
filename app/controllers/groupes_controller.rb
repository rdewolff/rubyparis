class GroupesController < ApplicationController
  before_filter :load_data
  
  def load_data
    nombres=[1, 2, 3, 4]
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @groupe_pages, @groupes = paginate :groupes, :per_page => 10
  end

  def show
    @groupe = Groupe.find(params[:id])
  end

  def new
    @groupe = Groupe.new
  end

  def create
    @groupe = Groupe.new(params[:groupe])
    if @groupe.save
      flash[:notice] = "Le groupe '" + @groupe.nom + "' a été créé avec succès!"
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @groupe = Groupe.find(params[:id])
  end

  def update
    @groupe = Groupe.find(params[:id])
    if @groupe.update_attributes(params[:groupe])
      flash[:notice] = "Le groupe '" + @groupe.nom + "' a été mis à jour avec succès!"
      redirect_to :action => 'show', :id => @groupe
    else
      render :action => 'edit'
    end
  end

  def destroy
    Groupe.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
