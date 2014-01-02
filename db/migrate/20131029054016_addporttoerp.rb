class Addporttoerp < ActiveRecord::Migration
  def up
	  add_column :erps, :port, :string
  end

  def down
  end
end
