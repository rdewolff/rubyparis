class CreateAdministrateurs < ActiveRecord::Migration
  def self.up
    create_table "administrateurs" do |t|
      
    end
    execute "alter table administrateurs add foreign key (id) references utilisateurs(id) on delete cascade"
  end

  def self.down
    drop_table :administrateurs
  end
end
