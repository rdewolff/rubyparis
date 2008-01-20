class CreatePersonnes < ActiveRecord::Migration
  def self.up
    create_table "personnes" do |t|
      t.column "nom", :string, :limit => 50, :null => false
      t.column "prenom", :string, :limit => 50, :null => false
    end
  end

  def self.down
    drop_table :personnes
  end
end
