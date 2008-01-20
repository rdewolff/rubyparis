class CreateCompetitions < ActiveRecord::Migration
  def self.up
    create_table "competitions" do |t|
      t.column "administrateur_id", :int, :null => false
      t.column "nom", :string, :limit => 50, :null => false
      t.column "description", :string, :limit => 100, :null => false
      t.column "dateDebut", :date
      t.column "dateFin", :date
    end
    execute "alter table competitions add constraint fk_administrateur foreign key (administrateur_id) references administrateur(id)"
  end

  def self.down
    drop_table :competitions
  end
end
