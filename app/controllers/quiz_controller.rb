class QuizController < ApplicationController
  before_filter :quiz, :except=>"index"
  before_filter :quiz_data, :except=>"index"

  layout Proc.new{|controller| controller.request.xhr? ? false : "quiz" }

  ### GET requests ###

  def index
    @quizzes = Quiz.all
  end

  def start_quiz ; end

  def question
    @question = @quiz.questions.find_by_id params[:question_id]
    redirect_to start_quiz_url(@quiz.short_name) unless @question
  end

  def results
    @result = @quiz.score @quiz_data
  end

  ### POST requests ###

  def restart
    session[:quiz_data][@quiz.short_name] = @quiz.init_session_data
    redirect_to start_quiz_url(params[:short_name])
  end

  def answer
    @quiz_data[params[:question_id].to_i] = params[:answer_id].to_i
    question = Question.find(params[:question_id])
    next_question = question.next.try :id

    if next_question
      redirect_to quiz_question_url(params[:short_name], next_question)
    else
      if @quiz_data.values.include? nil
        redirect_to quiz_question_url(params[:short_name], question.id)
      else
        redirect_to quiz_results_url(params[:short_name])
      end
    end
  end

  private

  def quiz
    @quiz = Quiz.find_by_short_name params[:short_name]
    raise "Couldn't find quiz #{params[:short_name]}" unless @quiz
  end

  def quiz_data
    session[:quiz_data] ||= {}
    session[:quiz_data][@quiz.short_name] ||= @quiz.init_session_data
    @quiz_data = session[:quiz_data][@quiz.short_name]
    puts session.inspect if RAILS_ENV=='development'
    @quiz_data
  end
end
