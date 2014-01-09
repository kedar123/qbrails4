class AdduserchoiceToUser < ActiveRecord::Migration
  def up
    add_column :users, :user_payment_choice, :string
  end

  def down
    
  end
end
