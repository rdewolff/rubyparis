class CreateEntraineurs < ActiveRecord::Migration
  def self.up
    create_table "entraineurs" do |t|
      
    end
    execute "alter table entraineurs add foreign key (id) references sportifs(id) on delete cascade"
  end

  def self.down
    drop_table :entraineurs
  end
end
