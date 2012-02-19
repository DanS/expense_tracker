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

end
