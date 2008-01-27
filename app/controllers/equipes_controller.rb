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
      flash[:notice] = 'Equipe was successfully created.'
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
      flash[:notice] = 'Equipe was successfully updated.'
      redirect_to :action => 'show', :id => @equipe
    else
      render :action => 'edit'
    end
  end

  def destroy
    Equipe.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end