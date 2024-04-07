class Expense < ApplicationRecord
  validates :description,:amount, presence: :true
  belongs_to :user
  has_many :expense_splits
  has_many :users,through: :expense_splits
  scope :shared_expenses_with_friend, ->(current_user_id, friend_id) {
    eager_load(:expense_splits)
      .where("(expenses.user_id = :current_user_id OR expenses.user_id = :friend_id)
            AND (expense_splits.user_id = :current_user_id OR expense_splits.user_id = :friend_id)",
             current_user_id: current_user_id, friend_id: friend_id)
  }
  scope :current_user_expenses, ->(current_user_id){
    eager_load(:expense_splits)
      .where("(expenses.user_id = :current_user_id)
            OR  (expense_splits.user_id = :current_user_id )",
             current_user_id: current_user_id)
  }
  scope :amount_due_to_current_user, ->(current_user_id){
    eager_load(:expense_splits)
      .where("expenses.user_id=:current_user_id AND expense_splits.paid_status = false",current_user_id: current_user_id).sum("expense_splits.amount")

  }
  scope :current_user_recovered_amount, ->(current_user_id){
    eager_load(:expense_splits)
      .where("expenses.user_id= :current_user_id AND expense_splits.paid_status = true",current_user_id: current_user_id)
      .sum("expense_splits.amount")
  }
  scope :expenses_due_to_current_user, ->(current_user_id){
    eager_load(:expense_splits)
      .where("expenses.user_id = :current_user_id",current_user_id: current_user_id)
  }

end
