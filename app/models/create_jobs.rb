class CreateJobs < ActiveRecord::Base
  belongs_to :user
  belongs_to :delayed_job
end
