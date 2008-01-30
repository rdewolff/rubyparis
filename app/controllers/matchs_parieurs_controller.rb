class MatchsParieursController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @matchs_parieur_pages, @matchs_parieurs = paginate :matchs_parieurs, :per_page => 10
  end

  def show
    @matchs_parieur = MatchsParieur.find(params[:id])
  end

  def new
    @matchs_parieur = MatchsParieur.new
  end

  def create
    @matchs_parieur = MatchsParieur.new(params[:matchs_parieur])
    if @matchs_parieur.save
      flash[:notice] = 'MatchsParieur was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @matchs_parieur = MatchsParieur.find(params[:id])
  end

  def update
    @matchs_parieur = MatchsParieur.find(params[:id])
    if @matchs_parieur.update_attributes(params[:matchs_parieur])
      flash[:notice] = 'MatchsParieur was successfully updated.'
      redirect_to :action => 'show', :id => @matchs_parieur
    else
      render :action => 'edit'
    end
  end

  def destroy
    MatchsParieur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
