class ExpenseSplit < ApplicationRecord
  validates :amount,presence: :true
  belongs_to :expense
  belongs_to :user


  scope :amount_owe_to_current_user, ->(current_user_id){
    where("user_id=:current_user_id",current_user_id: current_user_id).sum("amount")
  }

  scope :expenses_owe_to_current_user, ->(current_user_id){
    eager_load(:expense)
      .where("expense_splits.user_id = :current_user_id",current_user_id: current_user_id)
  }
end
