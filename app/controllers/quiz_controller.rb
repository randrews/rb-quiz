class QuizController < ApplicationController
  before_filter :find_quiz, :only=>:take_quiz
  before_filter :init_quiz_data, :only=>:take_quiz

  def take_quiz
    if @quiz_data[:current_question]==0
      render "take_quiz"
    else
      render "quiz_question"
    end
  end

  private

  def find_quiz
    @quiz = Quiz.find_by_short_name params[:short_name]
    raise "Couldn't find quiz #{params[:short_name]}" unless @quiz
  end

  def init_quiz_data
    session[:quiz_data] ||= {}
    session[:quiz_data][@quiz.short_name] ||= @quiz.init_session_data
    @quiz_data = session[:quiz_data][@quiz.short_name]
  end
end
