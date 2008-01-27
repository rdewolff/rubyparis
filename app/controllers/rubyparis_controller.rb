class RubyparisController < ApplicationController
  
  def index
    
  end
  
  def login
    @hashpw = Hashpw.new
    @utilisateur = Utilisateur.new(params[:utilisateur])
    
    puts @utilisateur.login
    puts session[:initial_uri]
    @utilisateur2 = Utilisateur.find(:first, :conditions => ["login = ?", @utilisateur.login])
    
    
    if @utilisateur2 and @hashpw.authenticate(@utilisateur2.password,@utilisateur.password)
      session[:user] = @utilisateur2
      redirect_to session[:initial_uri]
      
      
      #@parieur = Parieur.find_by_id(@utilisateur2.id)
      #@admin = Administrateur.find_by_id(@utilisateur2.id)
#      if @parieur
#        session[:parieur] = @parieur
#      elsif @admin
#        session[:admin] = @admin
#      end
    else
      flash[:notice] = "Login incorrect!"
    end
#    render :action => 'index'
  end
end
