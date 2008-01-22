class CreateArbitres < ActiveRecord::Migration
  def self.up
    create_table "arbitres" do |t|
      
    end
    execute "alter table arbitres add foreign key (id) references sportifs(id) on delete cascade"
  end

  def self.down
    drop_table :arbitres
  end
end
