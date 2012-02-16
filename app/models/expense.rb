class Expense < ActiveRecord::Base
  validates_presence_of :amount, :category
end
