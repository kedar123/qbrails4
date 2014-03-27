
class ImportsController < ApplicationController
  
  def home

   
    @import = Import.new
    Import.start_a_method
    
  end
 
  def index
    #begin
    #@ooor = Ooor.new(:url => "http://"+current_user.erp.url+":8069/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
    flash[:notice] = "Migration is started , you will shortly get an Email after Comletion of migration"   
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
      #here what i need to do create a seperate table where i am just keeping 2 values an user_id and 
    elsif current_user.user_payment_choice == "standard" 
      import.delay.export_standard_migration(current_user)
    elsif current_user.user_payment_choice == "premium"
      import.delay.export_premium_migration(current_user)
    end
      #import.export_testupdate_migration(current_user)
       logger.info "started background job" 
      #redirect_to home_index_path
      #instead of redirecting to a new path. im showing this same page. 
      redirect_to homes_path,:notice=>notice
  end   
 
 
  def download_quickbook
    send_file "#{Rails.root}/public/quick_openerp.tar.gz" 
  end
  
  def download_accessbook
    #send_data "#{Rails.root}/public/abrt7-setup.rar", i
#    file = "#{Rails.root}/public/abrt7-setup.rar"
#    data = ""
    #File.open(file, "w+"){ |f| f << data }
    #send_file( data )
    ######
#    File.open(file, "w+"){ |f| f << data }
#    send_file( file )
#send_data("#{Rails.root}/public/abrt7-setup.rar",
#    type: 'application/rar; charset=utf-8; header=present',
#    disposition: 'attachment; filename=abrt7-setup.rar'
#  )
send_file "#{Rails.root}/public/abrt7-setup.msi.zip", :type=>"application/zip" 
  end
  
  def download_manual
    send_file "#{Rails.root}/public/installation.pdf" 
  end
  
  # what here i need to check is weather a current user has the 
  #here i am checking following modules;
  def accessbook_success
        begin
         Database.connection.execute("use #{current_user.database.name}")
       if Company.count == 0
         render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       if Account.count == 0
         render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       if Customer.count == 0
         render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       if Vendor.count == 0
        render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       if Employee.count == 0
         render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       #for products i am assuming that at least 5 products are there.
      if((Itemsalestax.count + Itemsalestaxgroup.count + Itemservice.count + Itemdiscount.count + Itemfixedasset.count + Itemgroup.count + Iteminventory.count + Itemnoninventory.count + Iteminventoryassembly.count + Iteminventoryassembly.count + Itemothercharge.count + Itempayment.count + Itemsubtotal.count ) < 6    )
        render :text=>"incomplete",:layout=>false 
        Database.connection.execute("use mysqlquickbook")
        return
       end
       rescue => e
        logger.info "the error messageggegegege"
        logger.info e.inspect
        Database.connection.execute("use mysqlquickbook")
      ensure
        Database.connection.execute("use mysqlquickbook")
       end
    #if its come out from begin rescue then i need to send a response as complete
      Database.connection.execute("use mysqlquickbook")
       render :text=>"complete",:layout=>false
       #incomplete
  end 
 
  
end







