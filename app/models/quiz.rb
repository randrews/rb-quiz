class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :results

  validates_uniqueness_of :short_name
  validates_presence_of :short_name, :name

  def before_validation
    self.short_name ||= name.parameterize.to_s if name
  end

  # A hash of data that goes into the session when someone starts taking this quiz
  def init_session_data
    returning({}) do |data|
      data[:current_question] = 0
      questions.map(&:id).each{|a_id| data["#{a_id}_answer"] = nil}
    end
  end
end
