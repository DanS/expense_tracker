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
      flash[:error] = @expense.errors.full_messages
      render action: "new", error: @expense.errors.full_messages
    end
  end

  def update
    @expense = Expense.find params[:id]

    if @expense.update_attributes(params[:expense])
      redirect_to @expense, notice: "expense updated successfully"
    else
      flash[:error] = @expense.errors.full_messages
      render action: "edit", error: @expense.errors.full_messages
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    expense.destroy
    redirect_to expenses_path
  end
end
