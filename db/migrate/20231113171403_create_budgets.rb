class CreateBudgets < ActiveRecord::Migration[7.1]
  def change
    create_table :budgets do |t|
      t.datetime :creacion_date
      t.datetime :modification_date
      t.datetime :expiration_date
      t.decimal :total
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
