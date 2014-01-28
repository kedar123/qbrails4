
class ImportsController < ApplicationController
  
  def home

   
    @import = Import.new
    Import.start_a_method
    
  end
 
  def index
    #begin
    #@ooor = Ooor.new(:url => "http://"+current_user.erp.url+":8069/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
    flash[:Migration] = "Migration is started , you will shortly get an Email after Comletion of migration"   
       #Import.export_all_migration(current_user.database.name,current_user )
    logger.info "starting background job"
    #this i need to change it to delayed job
    #call_rake :import_database, :user_id => current_user.id
    import = Import.new
    import.save
    logger.info "some infffffffffffffffffffffffff"
    logger.info current_user.user_payment_choice
    #logger.info current_user.inspect
    if current_user.user_payment_choice == "free" 
      import.delay.export_free_migration(current_user)
    elsif current_user.user_payment_choice == "standard" 
      import.delay.export_standard_migration(current_user)
    elsif current_user.user_payment_choice == "premium"
      import.delay.export_premium_migration(current_user)
    end
      #import.export_testupdate_migration(current_user)
       logger.info "started background job" 
      #redirect_to home_index_path
      #instead of redirecting to a new path. im showing this same page. 
  end   
 
 
  def download_quickbook
    send_file "#{Rails.root}/public/quick_openerp.tar.gz" 
  end
  
  def download_accessbook
    send_file "#{Rails.root}/public/abrt7-setup.msi.tar.gz" 
  end
  
 
 
end







