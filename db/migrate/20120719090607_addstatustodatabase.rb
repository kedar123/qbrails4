class Addstatustodatabase < ActiveRecord::Migration
  def up
    add_column :databases,:status,:boolean
    add_column :databases,:started,:boolean
    add_column :databases,:completed,:boolean
  end

  def down
  end
end
