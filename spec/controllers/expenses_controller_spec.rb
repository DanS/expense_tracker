require 'spec_helper'

describe ExpensesController do
  let(:expense) {Factory(:expense)} #make expense memoized method available

  shared_examples_for "finding expense" do
    it "assigns expense" do
      assigns(:expense).should == expense
    end
  end

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

    it_should_behave_like "finding expense"

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

  describe "GET edit" do
    before do
      get :edit, :id => expense.to_param
    end

    it_should_behave_like "finding expense"

    it "renders the edit template" do
      response.should render_template "edit"
    end
  end
end
