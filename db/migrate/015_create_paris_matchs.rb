class CreateParisMatchs < ActiveRecord::Migration
  def self.up
    create_table("paris_matchs", id => false) do |t|
      t.column "parieur", :int, :null => false
      t.column "match_id", :int, :null => false
    end
    execute "alter table paris_matchs add foreign key (parieur) references parieurs(id) on delete cascade"
    execute "alter table paris_matchs add foreign key (match_id) references matchs(id)"
  end

  def self.down
    drop_table :paris_matchs
  end
end
