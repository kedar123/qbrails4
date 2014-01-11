class Addcoupentousers < ActiveRecord::Migration
  def change
    add_column :users,:coupenassigned,:string
  end
end
