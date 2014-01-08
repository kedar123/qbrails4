class Addaddresstousers < ActiveRecord::Migration
  def change
    
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users,:zip_code,   :string
    add_column :users,:mobile, :string
    add_column :users,:phone, :string
    add_column :users,:street, :string
    add_column :users,:address, :string
    
    
    
    
    
    
  end
end
