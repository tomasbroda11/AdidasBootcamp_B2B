class RemoveCreacionAndModificationDateFromBudgets < ActiveRecord::Migration[7.1]
  def change
    remove_column :budgets, :creacion_date, :datetime
    remove_column :budgets, :modification_date, :datetime
  end
end
