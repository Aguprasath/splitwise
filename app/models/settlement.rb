class Settlement < ApplicationRecord
  validates :amount,presence: :true
  belongs_to :expense_split
  belongs_to :user
end
