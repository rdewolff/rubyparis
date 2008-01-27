class EntraineursController < ApplicationController
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
    
    
    
#    Database.find_by_sql("SELECT p.nom, p.prenom, s.dateNaissance, s.taille, n.pays FROM personnes p, sportifs s, nations n WHERE p.id = s.id AND n.id = s.pays AND p.id IN (SELECT id FROM entraineurs)")
#    @test = execute "SELECT p.nom, p.prenom, s.dateNaissance, s.taille, n.pays FROM personnes p, sportifs s, nations n WHERE p.id = s.id AND n.id = s.pays AND p.id IN (SELECT id FROM entraineurs)"
#    puts @test.nom
    @entraineur_pages, @entraineurs = paginate :entraineurs, :per_page => 10
  end

  def show
    @entraineur = Entraineur.find(params[:id])
  end

  def new
    @entraineur = Entraineur.new
  end

  def create
    @personne = Personne.new(params[:personnes])
    @sportif = Sportif.new(params[:sportifs])
    @entraineur = Entraineur.new(params[:entraineurs])
    
    if @personne.save
      @sportif.id = @personne.id
      @entraineur.id = @sportif.id
      
      if @sportif.save && @entraineur.save
        flash[:notice] = 'Entraineur was successfully created.'
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
    @entraineur = Entraineur.find(params[:id])
  end

  def update
    @entraineur = Entraineur.find(params[:id])
    if @entraineur.update_attributes(params[:entraineurs])
      flash[:notice] = 'Entraineur was successfully updated.'
      redirect_to :action => 'show', :id => @entraineur
    else
      render :action => 'edit'
    end
  end

  def destroy
    Entraineur.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
end
