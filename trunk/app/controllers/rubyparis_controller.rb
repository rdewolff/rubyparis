class RubyparisController < ApplicationController
  
  def index
    
  end
  
  def login
    @hashpw = Hashpw.new
    @user = Utilisateur.new(params[:utilisateur])
    
    @utilisateur = Utilisateur.find(:first, :conditions => ["login = ?", @user.login])
    
    flash[:notice] = nil
    if @utilisateur and @hashpw.authenticate(@utilisateur.password,@user.password)
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
