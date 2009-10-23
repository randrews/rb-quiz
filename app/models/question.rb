class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, :order=>:order_num, :dependent=>:destroy

  # Returns the next question, or nil if there's not one
  def next
    index = quiz.questions.index(self)
    quiz.questions[index+1]
  end
end
