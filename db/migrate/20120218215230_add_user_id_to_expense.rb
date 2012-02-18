class AddUserIdToExpense < ActiveRecord::Migration
  def change
    change_table :expenses do |t|
      t.integer :user_id
    end
  end
end
