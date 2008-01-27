class CreateArbitres < ActiveRecord::Migration
  def self.up
    create_table "arbitres" do |t|
      
    end
    execute "alter table arbitres add foreign key (id) references sportifs(id) on delete cascade"
    execute "create view varbitres as select p.id, p.nom, p.prenom, s.dateNaissance, s.taille, n.pays FROM personnes p, sportifs s, nations n WHERE p.id = s.id AND n.id = s.pays AND p.id IN (SELECT id FROM arbitres)"
  end

  def self.down
    drop_table :arbitres
    execute "drop view varbitres"
  end
end
