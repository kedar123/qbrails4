class Coupen < ActiveRecord::Base

  #why i require the uniqueness of coupen is one coupen should be assign to one user
  
  validates_uniqueness_of :coupen
  
end
