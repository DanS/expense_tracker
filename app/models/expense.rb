class Expense < ActiveRecord::Base
  validates_presence_of :amount, :category, :user_id
  validates_numericality_of :amount
  validates_associated :user

  belongs_to :user

  def self.for_user(user)
    where(:user_id => user.id)
  end
end
