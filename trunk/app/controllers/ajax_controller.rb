class AjaxController < ApplicationController
  
  def liste_ajax
    @equipes = Equipe.find(:all, :conditions => "nom LIKE '%#{params[:eq]}%'")
  end
  
  
end