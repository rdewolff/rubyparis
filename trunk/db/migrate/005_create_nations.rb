class CreateNations < ActiveRecord::Migration
  def self.up
    create_table "nations" do |t|
      t.column "pays", :string, :limit => 30, :null => false
    end
  end

  def self.down
    drop_table :nations
  end
end
