class CreatePositions < ActiveRecord::Migration
  def self.up
    create_table "positions" do |t|
      t.column "position", :string, :limit => 20, :null => false
    end
  end

  def self.down
    drop_table :positions
  end
end
