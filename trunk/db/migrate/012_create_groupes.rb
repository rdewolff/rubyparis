class CreateGroupes < ActiveRecord::Migration
  def self.up
    create_table "groupes" do |t|
      t.column "competition_id", :int, :null => false
      t.column "nbEquipe", :int, :null => false
      t.column "allerRetour", :bool, :null => false
      t.column "termine", :bool, :null => false
      t.column "groupe_id", :int, :null => false
    end
    execute "alter table groupes add constraint fk_competition foreign key (competition_id) references competitions(id)"
    execute "alter table groupes add constraint fk_groupe foreign key (groupe_id) references groupes(id)"
  end

  def self.down
    drop_table :groupes
  end
end
