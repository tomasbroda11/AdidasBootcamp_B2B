class Product < ApplicationRecord
  belongs_to :category
  has_many :budget_items
end
