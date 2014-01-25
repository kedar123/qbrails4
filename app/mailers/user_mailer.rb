class UserMailer < ActionMailer::Base
   
    default sender: 'kedar.pathak21@pragtech.co.in'
    
   def welcome_email(user)
    @user = user
    @url  = 'http://178.63.19.197'
    mail(to: @user.email , subject: 'Welcome to QuickBooks To OpenERP Data Migration')
   end
  
   def sales_email(user)
     @user = user
     @url  = 'http://178.63.19.197'
     mail(to: 'kedar.pathak@pragtech.co.in'  , subject: 'New User Registered To QuickBook Site')
   end
   
  
   def migration_done(user)
    @user = user
    @url  = 'http://178.63.19.197'
    mail(to: @user.email , subject: 'Quickbook Migration')
   end 
   
   def feedback_sent(paramssubject,paramsbody,paramsemail)
    @user = User.find_by_email("kedar.pathak@pragtech.co.in")
    @url  = 'http://178.63.19.197'
    @paramssubject = paramssubject
    @paramsbody = paramsbody
    @paramsemail = paramsemail
    mail(to: @user.email , subject: 'Quickbook Migration Feedback')
   end
   
   
end
