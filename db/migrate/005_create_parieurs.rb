class CreateParieurs < ActiveRecord::Migration
  def self.up
    create_table "parieurs" do |t|
      
    end
    execute "alter table parieurs add constraint fk_utilisateur foreign key (id) references utilisateurs(id)"
  end

  def self.down
    drop_table :parieurs
  end
end
