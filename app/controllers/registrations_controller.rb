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
     
    p user_signed_in?
    #there are some issues with rails 4 devise that is why i have creaated this new model. 
    if current_user
    usd = Useraddress.new
    usd.user_id = current_user.id
    usd.country = params[:country]
    usd.state = params[:state]
    usd.zip_code = params[:zip_code]
    usd.mobile = params[:mobile]
    usd.phone = params[:phone]
    usd.address = params[:address]
    usd.save
    end
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
