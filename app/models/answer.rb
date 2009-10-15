class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :result

  has_one :quiz, :through=>:question
end
