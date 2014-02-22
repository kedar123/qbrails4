class UserMailer < ActionMailer::Base
   
    default sender: 'kedar.pathak21@pragtech.co.in'
    
   def welcome_email(user)
    @user = user
    @url  = 'http://openerp-data-migration.com'
    mail(to: @user.email , subject: 'Welcome to QuickBooks To OpenERP Data Migration')
   end
  
   def sales_email(user)
     @user = user
     @url  = 'http://openerp-data-migration.com'
     mail(to: 'openerp.datamigration@pragtech.co.in'  , subject: 'New User Registered To QuickBook Site')
   end
   
  
   def migration_done(user)
    @user = user
    @url  = 'http://openerp-data-migration.com'
    mail(to: @user.email , subject: 'Quickbook Migration')
   end 
   
   def feedback_sent(paramssubject,paramsbody,paramsemail)
    @user = User.find_by_email("openerp.datamigration@pragtech.co.in")
    @url  = 'http://openerp-data-migration.com'
    @paramssubject = paramssubject
    @paramsbody = paramsbody
    @paramsemail = paramsemail
    mail(to: @user.email , subject: 'Quickbook Migration Feedback')
   end
   
   
end
