require 'spec_helper'

describe Expense do
  describe "validations" do
    before do
      @expense = Factory(:expense)
    end

    it "is valid from the factory" do
      @expense.should be_valid
    end

    it "is not valid without amount" do
      @expense.amount = nil
      @expense.should_not be_valid
    end

    it "is not valid without category" do
      @expense.category = nil
      @expense.should_not be_valid
    end

    it "is not valid without user_id" do
      @expense.user_id = nil
      @expense.should_not be_valid
    end

    it "is not valid without valid associated user" do
      @expense.user.email = nil
      @expense.should_not be_valid
    end

    it "reports error when non-number assigned to amount" do
      @expense.amount = 'wrong'
      @expense.should_not be_valid
      @expense.errors.should_not be_empty
    end

  end

  describe "associations" do
    it "has a User" do
      subject.should respond_to :user
    end
  end

  describe "for_user method" do

    before do
      @user = Factory(:user)
      @user_expenses = (1..2).map {Factory(:expense, :user_id => @user.id)}.map(&:id)
      @others_expenses = (1..2).map {Factory(:expense)}.map(&:id)
    end

    it "returns nothing if user has no expenses" do
      user = Factory(:user)
      Expense.for_user(user).should be_empty
    end

    it "returns the expenses for user" do
      @user_expenses.should include(Expense.for_user(@user).first.id)
      @user_expenses.should include(Expense.for_user(@user).last.id)
    end

    it "does not return other users expenses" do
      @others_expenses.should_not include(Expense.for_user(@user).first.id)
      @others_expenses.should_not include(Expense.for_user(@user).last.id)
    end
  end
end
