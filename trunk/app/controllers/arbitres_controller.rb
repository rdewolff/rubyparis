class ArbitresController < ApplicationController
  before_filter :load_Sorted
  
  def load_Sorted
    @nations = Nation.find :all, :order=>"pays asc"
  end
  
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @arbitre_pages, @arbitres = paginate :arbitres, :per_page => 10
  end

  def show
    @arbitre = Arbitre.find(params[:id])
  end

  def new
    @arbitre = Arbitre.new
  end
  
  def format_date
    
  end
  
  def create
    @personne = Personne.new(params[:personnes])
    @sportif = Sportif.new(params[:sportifs])
    @arbitre = Arbitre.new(params[:arbitres])
    
    if @personne.save
      @sportif.id = @personne.id
      @arbitre.id = @sportif.id
      
      if @sportif.save && @arbitre.save
        flash[:notice] = 'Arbitre was successfully created.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
        
        Personne.delete(@personne.id)
      end
      
    else
      render :action => 'new'
    end
  end

  def edit
    @arbitre = Arbitre.find(params[:id])
  end

  def update
    @arbitre = Arbitre.find(params[:id])
    if @arbitre.update_attributes(params[:arbitre])
      flash[:notice] = 'Arbitre was successfully updated.'
      redirect_to :action => 'show', :id => @arbitre
    else
      render :action => 'edit'
    end
  end

  def destroy
    Arbitre.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
