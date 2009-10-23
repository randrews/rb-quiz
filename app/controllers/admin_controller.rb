class AdminController < ApplicationController
  require_role "admin", :for_all_except=>"not_allowed"

  def quizzes
    puts flash.inspect
    @quizzes = Quiz.all
  end

  def import_quiz
    if request.post?
      flash[:success]="Good on 'ya!"
      redirect_to :action=>"quizzes"
    end
  end
end
