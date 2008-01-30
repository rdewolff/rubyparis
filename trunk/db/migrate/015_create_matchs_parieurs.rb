class CreateMatchsParieurs < ActiveRecord::Migration
  def self.up
    create_table "matchs_parieurs", :id => false do |t|
      t.column "parieur_id", :int, :null => false
      t.column "match_id", :int, :null => false
      t.column "resultat", :int, :null => false
    end
    execute "alter table matchs_parieurs add foreign key (parieur_id) references parieurs(id)"
    execute "alter table matchs_parieurs add foreign key (match_id) references matchs(id)"
  end

  def self.down
    drop_table :matchs_parieurs
  end
end