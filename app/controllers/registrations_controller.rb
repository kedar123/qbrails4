class RegistrationsController < Devise::RegistrationsController
  layout 'user'
  def new
    super
  end

  def create
      #before calling a super need to check here a captcha
     
        # add custom create logic here
      
    if verify_recaptcha
          super
          if resource and resource.valid?
       #in create if an email already taken error occures then this if should not get execured. that is why resource.valid?
       #is get added here.
       usd = Useraddress.new
       usd.first_name = params[:first_name]
       usd.last_name = params[:last_name]
       usd.company = params[:company]
       usd.title = params[:title]
       usd.phone = params[:phone]
       usd.country = params[:country]
       usd.ip_address =  request.remote_addr
       usd.user_id =  resource.id
       usd.save
    else
    end
        else
          build_resource(sign_up_params)
          clean_up_passwords(resource)
          flash.now[:alert] = "There was an error with the recaptcha code below. Please re-enter the code."      
          flash.delete :recaptcha_error
          render :new
        end
    
    
       #but need to send an email
       #there are some issues with rails 4 devise that is why i have creaated this new model. 
     
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
 
  def resend_confirmation_email
    
    begin
    if params[:email]
       @user = User.find_by_email(params[:email])
       @user.send_reconfirmation_instructions
        
        
       flash[:notice] = "Confirmation Instruction Has Been Sent To Your Email Address"
       redirect_to :back   
    end
    rescue => e
      logger.info "some error while sending an email"
      logger.info e.inspect
      logger.info e.message
       
      flash[:notice] = "The Email Is Not Valid"
       
    end
    
  end
  
  
end 
