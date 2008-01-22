class CreateParieurs < ActiveRecord::Migration
  def self.up
    create_table "parieurs" do |t|
      
    end
    execute "alter table parieurs add foreign key (id) references utilisateurs(id) on delete cascade"
  end

  def self.down
    drop_table :parieurs
  end
end
