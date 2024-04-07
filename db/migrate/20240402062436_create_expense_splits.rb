class CreateExpenseSplits < ActiveRecord::Migration[7.0]
  def change
    create_table :expense_splits do |t|
      t.decimal :amount
      t.references :expense, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
