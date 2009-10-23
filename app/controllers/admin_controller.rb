class AdminController < ApplicationController
  require_role "admin"

  def index ; redirect_to :action=>"quizzes" ; end

  def quizzes
    @quizzes = Quiz.all
  end

  def delete
    if request.post?
      begin
        Quiz.find(params[:id]).destroy
        flash[:success]="Quiz deleted"
      rescue
        flash[:error]=$!.to_s
      end
    end

    redirect_to :action=>"quizzes"
  end

  def import_quiz
    if request.post?
      begin
        yaml = YAML.load(params[:quiz].read)
        raise "No quizzes in file" if yaml.keys.size==0

        yaml.each do |short_name, quiz_data|
          Quiz.transaction do
            if old_quiz = Quiz.find_by_short_name(short_name)
              old_quiz.destroy
            end

            quiz_fields = quiz_data.reject{|k,v| %w{questions results}.include? k}
            quiz = Quiz.create(quiz_fields.merge(:short_name=>short_name))

            results = {}
            quiz_data["results"].each do |result_data|
              result = Result.create result_data
              results[result.name] = result
              quiz.results << result
            end

            quiz_data["questions"].each_with_index do |question_data, question_order|
              question = Question.create(:question=>question_data["question"], :order_num=>question_order)

              question_data["answers"].each_with_index do |answer_data, answer_order|
                answer_fields = answer_data.reject{|k,v| k=="result"}
                answer = Answer.create(answer_fields.reverse_merge("order_num"=>answer_order,
                                                                   "result"=>results[answer_data["result"]],
                                                                   "points"=>1))

                question.answers << answer
              end

              quiz.questions << question
            end
          end
        end

        flash[:success]="Imported quiz#{yaml.keys.size>1 ? "zes" : ""}: #{yaml.keys.join(', ')}"
      rescue
        flash[:error] = "#{$!.to_s} at #{$!.backtrace.first.to_s}"
      end
      redirect_to :action=>"quizzes"
    end
  end
end
