class CreateUtilisateurs < ActiveRecord::Migration
  def self.up
    create_table "utilisateurs" do |t|
      t.column "login", :string, :limit => 50, :null => false
      t.column "password", :string, :limit => 40, :null => false
      t.column "email", :string, :limit => 100, :null => false
    end
    execute "alter table utilisateurs add constraint fk_personne foreign key (id) references personnes(id)"
  end

  def self.down
    drop_table :utilisateurs
  end
end
