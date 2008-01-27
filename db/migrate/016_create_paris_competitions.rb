class CreateParisCompetitions < ActiveRecord::Migration
  def self.up
    create_table ("paris_competitions", id => false) do |t|
      t.column "parieur", :int, :null => false
      t.column "competition", :int, :null => false
      t.column "resultat", :int, :null => false
    end
    execute "alter table paris_competitions add foreign key (parieur) references parieurs(id) on delete cascade"
    execute "alter table paris_competitions add foreign key (competition) references competitions(id)"
    execute "alter table paris_competitions add foreign key (resultat) references equipes(id)"
  end

  def self.down
    drop_table :paris_competitions
  end
end