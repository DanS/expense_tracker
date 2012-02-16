class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end
end
