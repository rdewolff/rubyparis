class MatchsParieursController < ApplicationController

  def annuler
    MatchsParieur.find(params[:id]).destroy
    redirect_to :action => 'paris', :id => params[:idC]
  end
  
  def paris
    
    if params[:id].nil?
      redirect_to :controller => 'home'
    else
      @competition = Competition.find(params[:id])
    end
  end
  
  def parier
    parieur_id = session[:user].id
    match_id = params[:id]
    @matchs_parieur = MatchsParieur.find(:first, :conditions => ["parieur_id = ? and match_id = ?", parieur_id, match_id])
    if @matchs_parieur.nil?
      @matchs_parieur = MatchsParieur.new(:parieur_id => parieur_id, :match_id => match_id, :resultat => params[:res])
    
      if @matchs_parieur.save
        flash[:notice] = 'Pari ajouté avec succès.'
      end
    else
      if @matchs_parieur.update_attribute(:resultat, params[:res])
        flash[:notice] = 'Pari ajouté avec succès.'
      end
    end
    redirect_to :action => 'paris', :id => params[:idC]
  end
  
end
