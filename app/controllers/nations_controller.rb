class NationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @nation_pages, @nations = paginate :nations, :per_page => 10
  end

  def show
    @nation = Nation.find(params[:id])
  end

  def new
    @nation = Nation.new
  end

  def create
    @nation = Nation.new(params[:nations])
    if @nation.save
      flash[:notice] = 'Nation was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @nation = Nation.find(params[:id])
  end

  def update
    @nation = Nation.find(params[:id])
    if @nation.update_attributes(params[:nations])
      flash[:notice] = 'Nation was successfully updated.'
      redirect_to :action => 'show', :id => @nation
    else
      render :action => 'edit'
    end
  end

  def destroy
    Nation.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
