class SettlementsController < ApplicationController


  def new
    @expense_split_id = params[:expense_split_id]
    @user_id = params[:user_id]
    @settlement = Settlement.new(amount: params[:amount])
  end

  def create
    @settlement = Settlement.create(settlement_params)
    @expense_split = ExpenseSplit.find(@settlement.expense_split_id)

    if @settlement.save
      @expense_split.update(paid_status: true)
      redirect_to expenses_path, notice: 'Settlement was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def settlement_params
    params.require(:settlement).permit(:expense_split_id, :user_id,:amount, :notes)
  end


end
