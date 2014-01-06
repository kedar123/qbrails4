class Feedback < ActiveRecord::Migration
  def up
    create_table :feedbacks, :force => true do |table|
                     
      table.string   :email                    # Who is working on this object (if locked)
      table.string   :subject
      table.text   :message
       
      table.timestamps
    end
  end

  def down
  end
end
