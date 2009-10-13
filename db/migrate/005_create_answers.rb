class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.string :answer
      t.integer :order_num
      t.integer :result_id
      t.integer :points, :default=>1
      t.integer :question_id
      t.timestamps
    end
  end

  def self.down
    drop_table :answers
  end
end
