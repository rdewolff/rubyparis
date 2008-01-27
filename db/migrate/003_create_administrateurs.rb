class CreateAdministrateurs < ActiveRecord::Migration
  def self.up
    create_table "administrateurs" do |t|
      
    end
    execute "alter table administrateurs add foreign key (id) references utilisateurs(id) on delete cascade"
    execute "create view vadministrateurs as select p.id, p.nom, p.prenom, u.login, u.password, u.email FROM personnes p, utilisateurs u WHERE p.id = u.id AND p.id IN (SELECT id FROM administrateurs)"
  end

  def self.down
    drop_table :administrateurs
    execute "drop view vadministrateurs"
  end
end
