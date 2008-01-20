class CreateAdministrateurs < ActiveRecord::Migration
  def self.up
    create_table "administrateurs" do |t|
      
    end
    execute "alter table administrateur add constraint fk_utilisateur foreign key (id) references utilisateurs(id)"
  end

  def self.down
    drop_table :administrateurs
  end
end
