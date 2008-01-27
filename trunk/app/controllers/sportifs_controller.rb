class SportifsController < ApplicationController
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }
  
  
  def list
    @sportif_pages, @sportifs = paginate :sportifs, :per_page => 10
  end

  def show
    @sportif = Sportif.find(params[:id])
  end

  def new
    @sportif = Sportif.new
#    @nations = Nation.find_all
  end

  def create
    @sportif = Sportif.new(params[:sportif])
    if @sportif.save
      flash[:notice] = 'Sportif was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @sportif = Sportif.find(params[:id])
 #   @nations = Nation.find_all
  end

  def update
    @sportif = Sportif.find(params[:id])
    if @sportif.update_attributes(params[:sportif])
      flash[:notice] = 'Sportif was successfully updated.'
      redirect_to :action => 'show', :id => @sportif
    else
      render :action => 'edit'
    end
  end

  def destroy
    Sportif.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
