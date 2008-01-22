class CreateUtilisateurs < ActiveRecord::Migration
  def self.up
    create_table "utilisateurs" do |t|
      t.column "login", :string, :limit => 50, :null => false
      t.column "password", :string, :limit => 42, :null => false
      t.column "email", :string, :limit => 100, :null => false
    end
    execute "alter table utilisateurs add foreign key (id) references personnes(id) on delete cascade"
  end

  def self.down
    drop_table :utilisateurs
  end
end
