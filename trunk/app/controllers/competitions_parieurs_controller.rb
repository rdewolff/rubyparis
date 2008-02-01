class CompetitionsParieursController < ApplicationController
  
  def pari
    
    if params[:id].nil?
      redirect_to :controller => 'home'
    else
      
      @competitions_parieur = CompetitionsParieur.find(:first,
        :conditions => ["parieur_id = ? and competition_id = ?",session[:user],params[:id]])
      
      @vainqueur = nil
      
      if !@competitions_parieur.nil?
        @equipeV = Equipe.find(@competitions_parieur.resultat)
        if !@equipeV.nil?
          @vainqueur = @equipeV.nom
        end
      end
      
      @competition = Competition.find(params[:id])
      @equipes = Array.new
      for t in @competition.groupe
        for m in t.match
          @equipes << m.equipea << m.equipeb
        end
      end
      @equipes = @equipes.uniq
    end
  end
  
  def parier
    idCompetition = params[:idCompetition]
    
    @parieur = session[:user]
    resultat = params[:competitions_parieur][:resultat]
    
    @competitions_parieur = CompetitionsParieur.find(:first,
    :conditions => ["parieur_id = ? and competition_id = ?",@parieur.id,idCompetition])
    
    if @competitions_parieur.nil?
      @competitions_parieur = CompetitionsParieur.new(:parieur_id => @parieur.id,
        :competition_id => idCompetition, :resultat => resultat)
      
      if @competitions_parieur.save
        flash[:notice] = 'Pari enregistré avec succès.'
      end
    else
      if @competitions_parieur.update_attribute(:resultat, resultat)
        flash[:notice] = 'Pari enregistré avec succès.'
      end
    end
    redirect_to :action => 'pari', :id => idCompetition
  end
  
  def annuler
    CompetitionsParieur.find(params[:id]).destroy
    puts params[:idC]
    redirect_to :action => 'pari', :id => params[:idC]
  end
  
end
