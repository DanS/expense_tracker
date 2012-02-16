class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :amount
      t.string :category
      t.text :description

      t.timestamps
    end
  end
end
