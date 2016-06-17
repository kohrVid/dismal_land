class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :author
      t.text :body
      t.references :location, foreign_key: true, index: true
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :comments
  end
end
