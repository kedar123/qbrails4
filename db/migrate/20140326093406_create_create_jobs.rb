class CreateCreateJobs < ActiveRecord::Migration
  def change
    #here i can have a relationship betn user and create jobs as 1-1 so user_id will be there
    #to get a normal information on reports
    create_table :create_jobs do |t|
      t.integer :user_id
      #to get all the user information
      t.string :migration_type
      t.integer :delayed_job_id
      t.timestamps
    end
  end
end
