class ExpensesController < ApplicationController
  def new
    @expense=Expense.new
  end

  def create

    @expense = Expense.create(expense_params.except(:user_ids))
    if @expense.save
      if params[:split_type] == 'equal'
        selected_user_ids = params[:expense][:user_ids].map(&:to_i) || params[:expense][:user_id].to_i
        total_amount = params[:expense][:amount].to_i
        split_amount = (total_amount.to_f / (selected_user_ids.length + 1)).round(2)
        selected_user_ids.each do |user_id|
          ExpenseSplit.create(expense_id: @expense.id, user_id: user_id, amount: split_amount) if user_id != @expense.user_id
        end
      elsif params[:split_type] == 'unequal'
        selected_user_ids = params[:expense][:user_ids].presence || params[:expense][:user_ids].to_i
        selected_user_ids = [selected_user_ids] unless selected_user_ids.is_a?(Array)
        selected_user_ids.each do |user_id|
          amount = params[:split_amount][user_id.to_s].to_f
          ExpenseSplit.create(expense_id: @expense.id, user_id: user_id, amount: amount) if user_id != @expense.user_id
        end
      end

      redirect_to expenses_path, notice: 'Expense created successfully.'
    else
       render :new, status: :unprocessable_entity
    end
  end


  def index
    @expenses=Expense.current_user_expenses(current_user.id)
    @amount_incurred=Expense.amount_due_to_current_user(current_user.id)
    @amount_owed=ExpenseSplit.amount_owe_to_current_user(current_user.id)
    @amount_recovered=Expense.current_user_recovered_amount(current_user.id)
  end

  def expenses_with_friend
    @friend=User.find(params[:friend_id])
    @friend_expenses=Expense.shared_expenses_with_friend(current_user.id,params[:friend_id])

  end

  def expenses_owe
    @expenses_owe=ExpenseSplit.expenses_owe_to_current_user(current_user.id)
  end

  def expenses_due
    @expenses_due=Expense.expenses_due_to_current_user(current_user.id)

  end

  private
  def expense_params
    params.require(:expense).permit(:description, :amount, :user_id,user_ids:[])

  end

end