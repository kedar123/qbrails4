class Addtitletousers < ActiveRecord::Migration
  def change
      add_column :useraddresses,:title,:string
      add_column :useraddresses,:company,:string
      add_column :useraddresses,:ip_address,:string
  end
end
