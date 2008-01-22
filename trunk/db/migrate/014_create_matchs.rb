class CreateMatchs < ActiveRecord::Migration
  def self.up
    create_table "matchs" do |t|
      t.column "groupe_id", :int, :null => false
      t.column "equipeA", :int, :null => false
      t.column "equipeB", :int, :null => false
      t.column "arbitre_id", :int, :null => false
      t.column "scoreA", :int
      t.column "scoreB", :int
      t.column "date", :date
      t.column "heure", :time
      t.column "lieu", :string, :limit => 30
    end
    execute "alter table matchs add foreign key (groupe_id) references groupes(id)"
    execute "alter table matchs add foreign key (equipeA) references equipes(id)"
    execute "alter table matchs add foreign key (equipeB) references equipes(id)"
    execute "alter table matchs add foreign key (arbitre_id) references arbitres(id)"
  end

  def self.down
    drop_table :matchs
  end
end
