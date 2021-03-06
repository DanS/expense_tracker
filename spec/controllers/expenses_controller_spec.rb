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
    before { sign_in @user }

    describe "GET index" do
      before do
        get :index
      end

      it "assigns @expenses" do
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
        let(:valid_attributes) { Factory.attributes_for(:expense) }

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
      before { @expense = Factory(:expense, :user_id => @user.id) }

      it "deletes the expense" do
        expect { delete :destroy, :id => @expense.to_param }.to change(Expense, :count).by(-1)
      end

      it "renders index" do
        delete :destroy, :id => @expense.to_param
        response.should redirect_to expenses_path
      end
    end

    describe "non admin user" do
      before {@other_users_expense = Factory(:expense)}

      it "does not see other users expenses in index" do
        get :index, {}
        assigns(:expenses).should_not include @other_users_expense
      end

      it "raises routing error when trying to show other users expense" do
        expect {get :show, :id => @other_users_expense.to_param}.to raise_error(ActionController::RoutingError)
      end

      it "raises routing error when trying to edit other users expense" do
        expect {get :edit, :id => @other_users_expense.to_param}.to raise_error(ActionController::RoutingError)
      end

      it "raises routing error when trying to update other users expense" do
        expect {put :update, :id => @other_users_expense.to_param, :expense => {:amount => 20}}.to raise_error(ActionController::RoutingError)
      end

      it "raises routing error when trying to delete other users expense" do
        expect {delete :destroy, :id => @other_users_expense.to_param}.to raise_error(ActionController::RoutingError)
      end

    end
  end

  describe "with unsigned in user" do
    before { sign_out @user }

    it "redirects index page requests to sign in page" do
      get :index, {}
      response.should redirect_to new_user_session_path
    end

    it "redirects show page requests to sign in page" do
      get :show, :id => expense.to_param
      response.should redirect_to new_user_session_path
    end

    it "redirects edit page requests to sign in page" do
      get :edit, :id => expense.to_param
      response.should redirect_to new_user_session_path
    end

    it "redirects new page requests to sign in page" do
      get :new
      response.should redirect_to new_user_session_path
    end

    it "will not create new expenses" do
      expect {
        post :create, :expense => Factory.attributes_for(:expense, :user_id => @user.id)
      }.not_to change(Expense, :count)
    end

    it "will not update expenses" do
      put :update, :id => expense.to_param, :expense => {:amount => 20}
      expense.reload.amount.should == 10
    end

    it "will not delete expenses" do
      @expense = Factory(:expense)
      expect { delete :destroy, :id => @expense.to_param }.not_to change(Expense, :count)
    end
  end
end
