class CreateImports < ActiveRecord::Migration
  def change
    create_table :imports do |t|
      t.string :dbname
      t.string :username
      t.string :password
      t.string :url 
      t.timestamps
    end
  end
end
