class PersonnesController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @personne_pages, @personnes = paginate :personnes, :per_page => 10
  end

  def show
    @personne = Personne.find(params[:id])
  end

  def new
    @personne = Personne.new
  end

  def create
    @personne = Personne.new(params[:personne])
    if @personne.save
      flash[:notice] = 'Personne was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @personne = Personne.find(params[:id])
  end

  def update
    @personne = Personne.find(params[:id])
    if @personne.update_attributes(params[:personne])
      flash[:notice] = 'Personne was successfully updated.'
      redirect_to :action => 'show', :id => @personne
    else
      render :action => 'edit'
    end
  end

  def destroy
    Personne.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
