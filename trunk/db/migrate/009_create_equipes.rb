class CreateEquipes < ActiveRecord::Migration
  def self.up
    create_table "equipes" do |t|
      t.column "entraineur_id", :int, :null => false
      t.column "nom", :string, :limit => 50, :null => false
      t.column "pays", :int, :null => false
      t.column "url", :string, :limit => 50, :null =>false
      t.column "stade", :string, :limit => 50, :null => false
      t.column "selection", :boolean, :default => false
    end
    execute "alter table equipes add foreign key (entraineur_id) references entraineurs(id)"
    execute "alter table equipes add foreign key (pays) references nations(id)"
  end

  def self.down
    drop_table :equipes
  end
end
