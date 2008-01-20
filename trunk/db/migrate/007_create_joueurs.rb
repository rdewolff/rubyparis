class CreateJoueurs < ActiveRecord::Migration
  def self.up
    create_table "joueurs" do |t|
      t.column "club", :int
      t.column "selection", :int
      t.column "position_id", :int, :null => false
    end
    execute "alter table joueurs add constraint fk_sportif foreign key (id) references sportifs(id)"
    execute "alter table joueurs add constraint fk_club foreign key (club) references equipes(id)"
    execute "alter table joueurs add constraint fk_selection foreign key (selection) references equipes(id)"
    execute "alter table joueurs add constraint fk_position foreign key (position_id) references positions(id)"
  end

  def self.down
    drop_table :joueurs
  end
end
