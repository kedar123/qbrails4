class AddColumnToDatabase < ActiveRecord::Migration
  def change
    add_column :databases, :erp_db_status, :boolean
  end
end
