class Quiz < ActiveRecord::Base
  has_many :questions
  has_many :results

  validates_uniqueness_of :short_name
  validates_presence_of :short_name, :name

  def before_validation
    self.short_name ||= name.parameterize.to_s if name
  end
end
