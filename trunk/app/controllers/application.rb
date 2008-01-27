# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_RORParis_session_id'
  
  def authenticate
    
    if session[:utilisateur].nil? && request.request_uri != "/parieurs/new"
      session[:initial_uri] = request.request_uri
      session[:notice] = "Vous n'êtes pas loggué!!"
      redirect_to :controller => "rubyparis", :action => "login"
    end
  end
  
end
