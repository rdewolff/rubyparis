class CreateSportifs < ActiveRecord::Migration
  def self.up
    create_table "sportifs" do |t|
      t.column "dateNaissance", :date, :null => false
      t.column "taille", :string, :limit => 4, :null => false
      t.column "pays", :int, :null => false
    end
    execute "alter table sportifs add constraint fk_personne foreign key (id) references personnes(id)"
    execute "alter table sportifs add constraint fk_pays foreign key (pays) references nations(id)"
  end

  def self.down
    drop_table :sportifs
  end
end
