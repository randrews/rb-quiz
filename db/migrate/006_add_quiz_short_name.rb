class AddQuizShortName < ActiveRecord::Migration
  def self.up
    add_column :quizzes, :short_name, :string
  end

  def self.down
    remove_column :quizzes, :short_name
  end
end
