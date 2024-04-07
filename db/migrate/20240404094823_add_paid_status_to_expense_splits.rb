class AddPaidStatusToExpenseSplits < ActiveRecord::Migration[7.0]
  def change
    add_column :expense_splits, :paid_status, :boolean,default: false
  end
end
