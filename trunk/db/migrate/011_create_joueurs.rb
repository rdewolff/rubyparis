class CreateJoueurs < ActiveRecord::Migration
  def self.up
    create_table "joueurs" do |t|
      t.column "club", :int
      t.column "selection", :int
      t.column "position_id", :int, :null => false
    end
    execute "alter table joueurs add foreign key (id) references sportifs(id)  on delete cascade"
    execute "alter table joueurs add foreign key (club) references equipes(id)"
    execute "alter table joueurs add foreign key (selection) references equipes(id)"
    execute "alter table joueurs add foreign key (position_id) references positions(id)"
  end

  def self.down
    drop_table :joueurs
  end
end
