class CreateBudgetItems < ActiveRecord::Migration[7.1]
  def change
    create_table :budget_items do |t|
      t.integer :amount
      t.references :product, null: false, foreign_key: true
      t.references :budget, null: false, foreign_key: true

      t.timestamps
    end
  end
end
