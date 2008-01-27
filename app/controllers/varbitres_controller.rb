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
    if @varbitre.save
      flash[:notice] = 'Varbitre was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @varbitre = Varbitre.find(params[:id])
  end

  def update
    @varbitre = Varbitre.find(params[:id])
    if @varbitre.update_attributes(params[:varbitre])
      flash[:notice] = 'Varbitre was successfully updated.'
      redirect_to :action => 'show', :id => @varbitre
    else
      render :action => 'edit'
    end
  end

  def destroy
    Varbitre.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
