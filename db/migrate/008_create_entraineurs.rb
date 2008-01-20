class CreateEntraineurs < ActiveRecord::Migration
  def self.up
    create_table "entraineurs" do |t|
      
    end
    execute "alter table entraineurs add constraint fk_sportif foreign key (id) references sportifs(id)"
  end

  def self.down
    drop_table :entraineurs
  end
end
