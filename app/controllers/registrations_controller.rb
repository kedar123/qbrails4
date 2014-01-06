class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    # add custom create logic here
    super
    #but need to send an email
    p "after logged in"
    p current_user
    begin
    UserMailer.welcome_email(current_user).deliver
    rescue=>e
      logger.info "there are some errors while sending an email"
      logger.info e.inspect
      logger.info e.message
    end
  end

  def update
    super
  end
end 
