class CreateSettlements < ActiveRecord::Migration[7.0]
  def change
    create_table :settlements do |t|
      t.decimal :amount
      t.references :expense_split, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :notes

      t.timestamps
    end
  end
end
