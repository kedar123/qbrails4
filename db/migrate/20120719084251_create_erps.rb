class CreateErps < ActiveRecord::Migration
  def change
    create_table :erps do |t|
      t.string :database
      t.string :username
      t.string :password
      t.string :url
      t.integer :user_id

      t.timestamps
    end
  end
end
