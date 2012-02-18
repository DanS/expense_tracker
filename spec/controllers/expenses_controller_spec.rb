require 'spec_helper'

describe ExpensesController do
  include Devise::TestHelpers
  render_views

  before do
    @user = Factory(:user)
  end
  
  let(:expense) { Factory(:expense, :user_id => @user.id) } #make expense memoized method available

  shared_examples_for "finding expense" do
    it "assigns expense" do
      assigns(:expense).should == expense
    end
  end

  describe "with signed in user" do
    before {sign_in @user}

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
      before { get :new }

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

    describe "POST create" do
      describe "with valid attributes" do
        let(:valid_attributes) { Factory.attributes_for(:expense, :user_id => @user.id) }

        it "saves a newly created expense" do
          expect {
            post :create, :expense => valid_attributes
          }.to change(Expense, :count).by(1)
        end

        it "renders the show template" do
          post :create, :expense => valid_attributes
          response.should redirect_to expense_path(assigns(:expense).id)
        end

        it "sets a flash message" do
          post :create, :expense => valid_attributes
          flash[:notice].should == "expense created successfully"
        end
      end

      describe "with invalid attributes" do

        it "saves a newly created expense" do
          expect {
            post :create, :expense => {}
          }.not_to change(Expense, :count)
        end

        it "re renders the new template" do
          post :create, :expense => {}
          response.should render_template "new"
        end

        it "sets a flash message" do
          post :create, :expense => {}
          flash[:error].should_not be_nil
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        before { put :update, :id => expense.to_param, :expense => {:amount => 20} }

        it_should_behave_like "finding expense"

        it "updates the expense" do
          expense.reload.amount.should == 20
        end

        it "redirects to the index" do
          response.should redirect_to expense
        end
      end

      describe "with invalid params" do
        before { put :update, :id => expense.to_param, :expense => {:amount => nil} }

        it "re renders the edit template" do
          response.should render_template "edit"
        end

        it "sets flash error" do
          flash[:error].should_not be_nil
        end
      end
    end

    describe "DELETE destroy" do
      before { @expense = Factory(:expense) }

      it "deletes the expense" do
        expect { delete :destroy, :id => @expense.to_param }.to change(Expense, :count).by(-1)
      end

      it "renders index" do
        delete :destroy, :id => @expense.to_param
        response.should redirect_to expenses_path
      end
    end
  end

end
