class CreateDirections < ActiveRecord::Migration
  def self.up
    create_table :directions do |t|
      t.references :location, foreign_key: true, index: true
      t.references :destination, foreign_key: true, index: true
      t.string :direction
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :directions
  end
end
