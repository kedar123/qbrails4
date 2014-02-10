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
   
  def first_confirmation?
    previous_changes[:confirmed_at] && previous_changes[:confirmed_at].first.nil?
  end

  def confirm!
    super
    if first_confirmation?
         begin
    #UserMailer.welcome_email(current_user).deliver
    
    UserMailer.sales_email(self).deliver
    rescue=>e
      logger.info "there are some errors while sending an email"
      logger.info e.inspect
      logger.info e.message
    end
    #redirect_to root_path
    end
  end
  
end
