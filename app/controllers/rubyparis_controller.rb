class RubyparisController < ApplicationController
  
  def index
    
  end
  
  def login
    @hashpw = Hashpw.new
    @utilisateur = Utilisateur.new(params[:utilisateur])
    
    @utilisateur = Utilisateur.find(:first, :conditions => ["login = ?", @utilisateur.login])
    
    
    if @utilisateur and @hashpw.authenticate(@utilisateur.password,@utilisateur.password)
      session[:admin] = Administrateur.find(:first, :conditions => ["id = ?", @utilisateur.id])
      session[:user] = @utilisateur
    else
      flash[:notice] = "Login incorrect!"
    end
    render :action => 'index'
  end
  
  def logout
    reset_session
    redirect_to :action => "home"
  end
  
end
