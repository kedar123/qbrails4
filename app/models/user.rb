class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:confirmable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me
   #attr_accessible :last_sign_in_ip,:country,:state,:zip_code,:mobile,:phone,:street,:address
  #validates_presence_of :country,:state,:zip_code,:mobile,:phone,:street,:address ,on: :create
  has_one :database
  has_one :erp
  has_one :useraddress
   
  
  
end
