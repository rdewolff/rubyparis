class CreateJoueurs < ActiveRecord::Migration
  def self.up
    create_table "joueurs" do |t|
      t.column "club", :int
      t.column "selection", :int
      t.column "position_id", :int, :null => false
    end
    execute "alter table joueurs add foreign key (id) references sportifs(id)  on delete cascade"
    execute "alter table joueurs add foreign key (club) references equipes(id)"
    execute "alter table joueurs add foreign key (selection) references equipes(id)"
    execute "alter table joueurs add foreign key (position_id) references positions(id)"
    execute "create view vjoueurs as select p.id, p.nom, 
      p.prenom, s.dateNaissance, s.taille, n.pays, po.position, j.club, j.selection FROM personnes p, 
      sportifs s, nations n, positions po, equipes e, joueurs j WHERE p.id = s.id AND n.id = s.pays
      AND po.id = j.position_id AND e.id = j.club AND e.id = j.selection
      AND p.id IN (SELECT id FROM joueurs)"
  end

  def self.down
    drop_table :joueurs
    execute "drop view vjoueurs"
  end
end
