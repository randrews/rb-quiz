class Result < ActiveRecord::Base
  belongs_to :quiz

  before_destroy{|r| r.answers.empty? }

  def answers
    quiz.questions.map(&:answers).flatten.reject{|a| a.result!=self}
  end
end
