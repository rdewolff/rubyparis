class NationsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @nation_pages, @nations = paginate :nations, :per_page => 10, :order => "pays asc"
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
      @equipe = Equipe.new(:nom => @nation.pays,
        :pays => @nation.id, :selection => 1)
      if @equipe.save
        flash[:notice] = 'Pays et selection nationale créés.'
        redirect_to :action => 'list'
      else
        render :action => 'new'
      end
    else
      render :action => 'new'
    end
  end

  def edit
    @nation = Nation.find(params[:id])
  end

  def update
    @nation = Nation.find(params[:id])
    @equipe = Equipe.find(:first, :conditions => ["pays = ? and selection = 1", @nation.id])
    
    if @nation.update_attributes(params[:nations]) && @equipe.update_attributes(:nom => @nation.pays)
      flash[:notice] = 'Pays et selection nationale modifiés avec succès.'
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
