class Addfirstnametousers < ActiveRecord::Migration
  def change
    add_column :useraddresses,:first_name,:string
    add_column :useraddresses,:middle_name,:string
    add_column :useraddresses,:last_name,:string
    
    
  end
end
