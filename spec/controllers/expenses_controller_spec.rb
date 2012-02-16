require 'spec_helper'

describe ExpensesController do

  describe "GET index" do
    it "assigns all expenses as @expenses" do
      get :index
      assigns(:expenses).should_not be_nil
    end

    it "renders the index template" do
      get :index
      response.should render_template "index"
    end
  end
end
