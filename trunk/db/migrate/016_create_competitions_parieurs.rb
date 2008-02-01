class CreateCompetitionsParieurs < ActiveRecord::Migration
  def self.up
    create_table "competitions_parieurs" do |t|
      t.column "parieur_id", :int, :null => false
      t.column "competition_id", :int, :null => false
      t.column "resultat", :int, :null => false
    end
    execute "alter table competitions_parieurs add foreign key (parieur_id) references parieurs(id)"
    execute "alter table competitions_parieurs add foreign key (competition_id) references competitions(id)"
    execute "alter table competitions_parieurs add foreign key (resultat) references equipes(id)"
  end

  def self.down
    drop_table :competitions_parieurs
  end
end