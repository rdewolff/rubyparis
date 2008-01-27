class CreateEntraineurs < ActiveRecord::Migration
  def self.up
    create_table "entraineurs" do |t|
      
    end
    execute "alter table entraineurs add foreign key (id) references sportifs(id) on delete cascade"
    execute "create view ventraineurs as select p.id, p.nom, p.prenom, s.dateNaissance, s.taille, n.pays FROM personnes p, sportifs s, nations n WHERE p.id = s.id AND n.id = s.pays AND p.id IN (SELECT id FROM entraineurs)"
  end

  def self.down
    drop_table :entraineurs
    execute "drop view ventraineurs"
  end
end
