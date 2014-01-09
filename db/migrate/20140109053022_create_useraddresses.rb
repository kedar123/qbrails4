class CreateUseraddresses < ActiveRecord::Migration
  def change
    create_table :useraddresses do |t|
      t.string   :country
      t.string   :state
      t.string   :zip_code
      t.string   :mobile
      t.string   :phone
      t.string   :street
      t.string   :address
      t.integer  :user_id
      t.timestamps
    end
  end
end
