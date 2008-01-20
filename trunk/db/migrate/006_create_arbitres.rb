class CreateArbitres < ActiveRecord::Migration
  def self.up
    create_table "arbitres" do |t|
      
    end
    execute "alter table arbitres add constraint fk_sportif foreign key (id) references sportifs(id)"
  end

  def self.down
    drop_table :arbitres
  end
end
