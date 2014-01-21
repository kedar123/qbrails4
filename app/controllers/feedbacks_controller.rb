
class FeedbacksController < ApplicationController
  
  skip_before_filter :authenticate_user!
  layout "prof"
  
  def create
    feedback = Feedback.new(:email=>params[:email],:subject=>params[:subject],:message=>params[:message])
    feedback.save
    begin
    
    UserMailer.feedback_sent(params[:subject],params[:message],params[:email]).deliver
    rescue => e
      logger.info "some error while sending an email"
    end
    flash[:notice] = "Your Message Has Been Sent To Site Admin"
    redirect_to feedbacks_contactus_path
    
  end
  
  def aboutus
    
  end
  
  def contactus
    
  end
  
  
  
end
