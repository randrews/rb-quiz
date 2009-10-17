class Quiz < ActiveRecord::Base
  has_many :questions, :order=>:order_num
  has_many :results

  validates_uniqueness_of :short_name
  validates_presence_of :short_name, :name

  def before_validation
    self.short_name ||= name.parameterize.to_s if name
  end

  # A hash of data that goes into the session when someone starts taking this quiz
  def init_session_data
    returning({}) do |data|
      questions.map(&:id).each{|a_id| data[a_id] = nil}
    end
  end

  def score quiz_data
    scores = Hash.new 0
    results.each{|r| scores[r.id]=0}

    questions.each do |q|
      answer = Answer.find_by_id(quiz_data[q.id]) or next
      scores[answer.result] += answer.points if answer.quiz == self
    end

    result_id = scores.to_a.sort{|(r1,s1),(r2,s2)| s2<=>s1}.first[0]
    Result.find_by_id result_id
  end
end
