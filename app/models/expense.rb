class Expense < ActiveRecord::Base
  validates_presence_of :amount, :category, :user_id
  validates_numericality_of :amount


  belongs_to :user
end
