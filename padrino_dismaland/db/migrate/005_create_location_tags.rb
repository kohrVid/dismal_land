class CreateLocationTags < ActiveRecord::Migration
  def self.up
    create_table :location_tags do |t|
      t.references :location, foreign_key: true, index: true
      t.references :tag, foreign_key: true, index: true
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :location_tags
  end
end
