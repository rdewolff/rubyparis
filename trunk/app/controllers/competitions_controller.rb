class CompetitionsController < ApplicationController
  def index
    list
    render :action => 'list'
  end

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create, :update ],
         :redirect_to => { :action => :list }

  def list
    @competition_pages, @competitions = paginate :competitions, :per_page => 20
  end

  def show
    if params[:id].nil?
      redirect_to :controller => 'home'
    else
      @competition = Competition.find(params[:id])
      @groupes = Array.new
      
     for g in @competition.groupe
        @equipesGroupes = Array.new
        for m in g.match
          @equipesGroupes << m.equipea.nom << m.equipeb.nom
        end
        @groupes << [g.nom,@equipesGroupes.uniq]
      end
    end
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(params[:competition])
    if @competition.save
      flash[:notice] = 'Competition was successfully created.'
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end

  def edit
    @competition = Competition.find(params[:id])
  end

  def update
    @competition = Competition.find(params[:id])
    if @competition.update_attributes(params[:competition])
      flash[:notice] = 'Competition was successfully updated.'
      redirect_to :action => 'show', :id => @competition
    else
      render :action => 'edit'
    end
  end
  
  def prochaines_compets
    @competition_pages, @competitions = paginate :competitions, :per_page => 10
    render( :layout => false) # n'affiche pas le layout
  end

  def destroy
    Competition.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
