class CreateParieurs < ActiveRecord::Migration
  def self.up
    create_table "parieurs" do |t|
      
    end
    execute "alter table parieurs add foreign key (id) references utilisateurs(id) on delete cascade"
    execute "create view vparieurs as select p.id, p.nom, p.prenom, u.login, u.password, u.email FROM personnes p, utilisateurs u WHERE p.id = u.id AND p.id IN (SELECT id FROM parieurs)"
  end

  def self.down
    drop_table :parieurs
    execute "drop view vparieurs"
  end
end
