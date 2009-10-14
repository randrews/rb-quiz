class Question < ActiveRecord::Base
  belongs_to :quiz
  has_many :answers, :order=>:order_num
end
