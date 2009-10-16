class QuizController < ApplicationController
=begin
The general flow of actions looks like this:

Take_quiz is a dispatcher. It sends you to either a
title page, a question page or a results page
depending on your session.

Going to /foo takes you to the take_quiz for foo,
which initially creates your session data and shows
you a quiz title page.

This has a "start quiz" link that sends you to
/foo/start, which updates your current_question to
the first question and sends you back to take_quiz.

When you answer a question, it sends you to answer,
which updates your session and sends you back to
take_quiz.

Eventually you reach the end of the questions, and
take_quiz sends you to a quiz_results page.
=end

  before_filter :quiz
  before_filter :quiz_data

  def take_quiz
    puts session.inspect if RAILS_ENV=='development'

    if @quiz_data[:current_question]==0
      render_or_partial "start_quiz"
    elsif @quiz_data[:current_question].nil?
      @result = @quiz.score @quiz_data
      render_or_partial "quiz_results"
    else
      @current_question = @quiz.questions.find_by_id @quiz_data[:current_question]
      render_or_partial "quiz_question"
    end
  end

  def restart
    session[:quiz_data][@quiz.short_name] = @quiz.init_session_data
    redirect_to take_quiz_url(params[:short_name])
  end

  def start
    @quiz_data[:current_question] = @quiz.questions.first.id
    redirect_to take_quiz_url(params[:short_name])
  end

  def answer
    @quiz_data["#{params[:question_id]}_answer"] = params[:answer_id]
    @current_question = Question.find(params[:question_id])
    @quiz_data[:current_question] = @current_question.next.try :id

    redirect_to take_quiz_url(params[:short_name])
  end

  private

  def render_or_partial name
    render(request.xhr? ? {:partial=>name} : name)
  end

  def quiz
    @quiz = Quiz.find_by_short_name params[:short_name]
    raise "Couldn't find quiz #{params[:short_name]}" unless @quiz
  end

  def quiz_data
    session[:quiz_data] ||= {}
    session[:quiz_data][@quiz.short_name] ||= @quiz.init_session_data
    @quiz_data = session[:quiz_data][@quiz.short_name]
  end
end
