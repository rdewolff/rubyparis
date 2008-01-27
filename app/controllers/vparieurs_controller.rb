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
    if @vparieur.save
      flash[:notice] = 'Vparieur was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @vparieur = Vparieur.find(params[:id])
  end

  def update
    @vparieur = Vparieur.find(params[:id])
    if @vparieur.update_attributes(params[:vparieur])
      flash[:notice] = 'Vparieur was successfully updated.'
      redirect_to :action => 'show', :id => @vparieur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Vparieur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
