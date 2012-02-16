class ExpensesController < ApplicationController

  def index
    @expenses = Expense.all
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    @expense = Expense.new params[:expense]

    if @expense.save
      redirect_to @expense, notice: "expense created successfully"
    else
      flash[:error] =  @expense.errors.full_messages
      render action: "new", error: @expense.errors.full_messages
    end
  end
end
