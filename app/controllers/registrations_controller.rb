class RegistrationsController < Devise::RegistrationsController
  layout 'user'
  def new
    super
  end

  def create
    # add custom create logic here
    super
    #but need to send an email
    
    #there are some issues with rails 4 devise that is why i have creaated this new model. 
  
    if resource
    usd = Useraddress.new
    usd.user_id = resource.id
    usd.country = params[:country]
    usd.state = params[:state]
    usd.zip_code = params[:zip_code]
    usd.mobile = params[:mobile]
    usd.phone = params[:phone]
    usd.address = params[:address]
    usd.first_name = params[:first_name]
    usd.middle_name = params[:middle_name]
    usd.last_name = params[:last_name]
    usd.save
    else
    end
    #begin
    #UserMailer.welcome_email(current_user).deliver
    #UserMailer.sales_email(current_user).deliver
    #rescue=>e
    #  logger.info "there are some errors while sending an email"
    #  logger.info e.inspect
    #  logger.info e.message
    #end
    #redirect_to root_path
  end

  def update
    super
  end
 
end 
