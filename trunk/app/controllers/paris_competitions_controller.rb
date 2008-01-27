class ParisCompetitionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @paris_competition_pages, @paris_competitions = paginate :paris_competitions, :per_page => 10
  end

  def show
    @paris_competition = ParisCompetition.find(params[:id])
  end

  def new
    @paris_competition = ParisCompetition.new
  end

  def create
    @paris_competition = ParisCompetition.new(params[:paris_competition])
    if @paris_competition.save
      flash[:notice] = 'ParisCompetition was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @paris_competition = ParisCompetition.find(params[:id])
  end

  def update
    @paris_competition = ParisCompetition.find(params[:id])
    if @paris_competition.update_attributes(params[:paris_competition])
      flash[:notice] = 'ParisCompetition was successfully updated.'
      redirect_to :action => 'show', :id => @paris_competition
    else
      render :action => 'edit'
    end
  end

  def destroy
    ParisCompetition.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
