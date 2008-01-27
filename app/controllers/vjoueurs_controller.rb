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
    if @vjoueur.save
      flash[:notice] = 'Vjoueur was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @vjoueur = Vjoueur.find(params[:id])
  end

  def update
    @vjoueur = Vjoueur.find(params[:id])
    if @vjoueur.update_attributes(params[:vjoueur])
      flash[:notice] = 'Vjoueur was successfully updated.'
      redirect_to :action => 'show', :id => @vjoueur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Vjoueur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
