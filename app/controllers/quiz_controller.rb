class QuizController < ApplicationController
  before_filter :find_quiz, :only=>:take_quiz

  def take_quiz
  end

  private

  def find_quiz
    @quiz = Quiz.find_by_short_name params[:short_name]
    raise "Couldn't find quiz #{params[:short_name]}" unless @quiz
  end
end
