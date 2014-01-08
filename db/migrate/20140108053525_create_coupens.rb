class CreateCoupens < ActiveRecord::Migration
  def change
    create_table :coupens do |t|
      t.string :coupen

      t.timestamps
    end
  end
end
