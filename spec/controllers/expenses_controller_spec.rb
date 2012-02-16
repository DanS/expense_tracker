require 'spec_helper'

describe ExpensesController do
  let(:expense) {Factory(:expense)} #make expense memoized method available

  describe "GET index" do
    before do
      get :index
    end

    it "assigns all expenses as @expenses" do
      assigns(:expenses).should_not be_nil
    end

    it "renders the index template" do
      response.should render_template "index"
    end
  end

  describe "GET show" do
    before do
      get :show, :id => expense.to_param
    end

    it "assigns an expense" do
      assigns(:expense).should == expense
    end

    it "renders the show template" do
      response.should render_template "show"
    end
  end

  describe "GET new" do
    before {get :new}

    it "assigns a new expense" do
      assigns(:expense).should be_kind_of Expense
    end

    it "renders the new template" do
      response.should render_template "new"
    end
  end
end
