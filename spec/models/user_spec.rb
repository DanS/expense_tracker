require 'spec_helper'

describe User do
  describe "validations" do
    before {@user = Factory.build(:user)}

    it "is valid from the factory" do
      @user.should be_valid
    end

    it "is not valid without a name" do
      @user.name = nil
      @user.should_not be_valid
    end
  end
end
