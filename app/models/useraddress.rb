class Useraddress < ActiveRecord::Base
   
  #validates :country,:state,:zip_code,:mobile,:phone,:street,:address, presence: true
  belongs_to :user
end
