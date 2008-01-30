class CompetitionsParieursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @competitions_parieur_pages, @competitions_parieurs = paginate :competitions_parieurs, :per_page => 10
  end

  def show
    @competitions_parieur = CompetitionsParieur.find(params[:id])
  end

  def new
    @competitions_parieur = CompetitionsParieur.new
  end

  def create
    @competitions_parieur = CompetitionsParieur.new(params[:competitions_parieur])
    if @competitions_parieur.save
      flash[:notice] = 'CompetitionsParieur was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @competitions_parieur = CompetitionsParieur.find(params[:id])
  end

  def update
    @competitions_parieur = CompetitionsParieur.find(params[:id])
    if @competitions_parieur.update_attributes(params[:competitions_parieur])
      flash[:notice] = 'CompetitionsParieur was successfully updated.'
      redirect_to :action => 'show', :id => @competitions_parieur
    else
      render :action => 'edit'
    end
  end

  def destroy
    CompetitionsParieur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def pari
    @competition = Competitions.new(params[:id])
if product.save
  product.options << Option.find_by_name("red")
end
  end
end
