class ParisMatchsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @paris_match_pages, @paris_matchs = paginate :paris_matchs, :per_page => 10
  end

  def show
    @paris_match = ParisMatch.find(params[:id])
  end

  def new
    @paris_match = ParisMatch.new
  end

  def create
    @paris_match = ParisMatch.new(params[:paris_match])
    if @paris_match.save
      flash[:notice] = 'ParisMatch was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @paris_match = ParisMatch.find(params[:id])
  end

  def update
    @paris_match = ParisMatch.find(params[:id])
    if @paris_match.update_attributes(params[:paris_match])
      flash[:notice] = 'ParisMatch was successfully updated.'
      redirect_to :action => 'show', :id => @paris_match
    else
      render :action => 'edit'
    end
  end

  def destroy
    ParisMatch.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
