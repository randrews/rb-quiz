class CreateResults < ActiveRecord::Migration
  def self.up
    create_table :results do |t|
      t.string :name
      t.text :description
      t.integer :quiz_id
      t.timestamps
    end
  end

  def self.down
    drop_table :results
  end
end
