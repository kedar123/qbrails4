class Import < ActiveRecord::Base
  
  #this is just a test method
  def export_testupdate_migration(current_user)
    @error = false
    @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
    logger.info "dbbbbbbbbbbbbbb       name     receiveddddddddddddddd s "
    logger.info dbname
    logger.info dbname
    logger.info dbname
    Database.connection.execute("use #{current_user.database.name}")
    Database.connection.execute("use oct_4") 
  end
  
  def export_premium_migration(current_user)
    
    @error = false
   
    begin
      @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)


      logger.info "dbbbbbbbbbbbbbb       name     receiveddddddddddddddd s "
      logger.info dbname
      logger.info dbname
      logger.info dbname
      Database.connection.execute("use #{current_user.database.name}")
      company = Company.find(:all)
    	Company.export_company(company,current_user)	
      account = Account.all
  	  Account.export_account(account,current_user)
      logger.info "Account End>>>>>>>>>>>>>>>>>>"
     
     
      logger.info "Customer.....calleddd..........."
      custmr = Customer.find(:all)#,:limit=>10)#Customer.all  
      Customer.call_customer_save(custmr,current_user)
      logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      #		  

      logger.info  "vendorr  ....................calleddd"
		  vendr = Vendor.find(:all)#,:limit=>10)#Vendor.all  
      Vendor.call_vendor_save(vendr,current_user)
     
	    employee = Employee.all
      Employee.import_employee(employee,current_user)


      logger.info "Bill migrating............ calleddd8944849648"
      logger.info "zzzzzzzzzzzzzzzzzz"
      itemsalestax = Itemsalestax.find(:all)#Itemsalestax.all
      logger.info "ccccccccccccccccccccccccccc"
      Itemsalestax.export_item(itemsalestax,current_user)
  
 	    logger.info "item sales tax group"
      itemsalestg = Itemsalestaxgroup.find(:all)
      Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
    
      
      
      
		  logger.info "Itemservice calleddd"
      logger.info "Itemservice calleddd"
 	    itemserv = Itemservice.find(:all)#Itemservice.all 
      Itemservice.export_itemservices(itemserv,current_user)
 
 			logger.info "Itemdiscountttt......... calleddd"
      # 		
      logger.info	"Itemdiscountttt......... calleddd"
			itemdiscnt = Itemdiscount.find(:all)#Itemdiscount.all
			Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
      #	


   		logger.info "Itemfixedasset................. calleddd"
      logger.info	"Itemfixedasset................. calleddd"
 			itemfixasset = Itemfixedasset.find(:all)#Itemfixedasset.all 
   		Itemfixedasset.export_itemfixassets(itemfixasset,current_user)


 			logger.info "Itemgroup ........... calleddd"
      logger.info "Itemgroup ........... calleddd"
  		itemgroup = Itemgroup.find(:all)#Itemgroup.all
 	 		Itemgroup.export_itemgroups(itemgroup,current_user)
			logger.info "Iteminventry.............. calleddd"

      #   		
      # 
      logger.info	"Iteminventry.............. calleddd"
			iteminventory = Iteminventory.find(:all)#Iteminventory.all
      Iteminventory.export_iteminventories(iteminventory,current_user)
			logger.info "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"

      #			
      logger.info	 "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
			itemnoninventory = Itemnoninventory.find(:all)#Itemnoninventory.all
			Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
			logger.info "Iteminventoryassembly................... calleddd"

      # 			
      #       
			iteminventoryassembly = Iteminventoryassembly.find(:all)#Iteminventoryassembly.all      
 			Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
			logger.info "Itemmothercharge.................. calleddd"

      # 			
      #       

 
	  
      
 			itemothercharge = Itemothercharge.find(:all)#Itemothercharge.all
			Itemothercharge.export_itemothercharge(itemothercharge,current_user)
    	logger.info "Itempaymentt.................. calleddd"

      #  		
      #   
      #       
  	  itempayment = Itempayment.find(:all)#Itempayment.all 
 			Itempayment.export_itempayment(itempayment,current_user)
			logger.info "ItemService................... calleddd"
			logger.info "ItemService................... calleddd"
 
      itemsubtotal = Itemsubtotal.find(:all)#Itemsubtotal.all
      Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
      
       
      logger.info "sales receipt is done"
      
     	logger.info "invoice called ....successfullyyyyyyyyy.."
		 
    rescue => e
   
      logger.info "in rescue error occureddd"
      logger.info "ssssssssssssssssssssssssss"
      logger.info "in rescue error occureddd"
      logger.info e
      logger.info e.to_s
      logger.info e.message  
      logger.info e.backtrace.inspect 
    
      logger.info "connectinggggg to oct_4" 
      Database.connection.execute("use mysqlquickbook")
      @error = true
    end
    logger.info "connectinggggg to oct_4" 
    #if there is no error in begin rescue above then i should send an email otherwise database status is also need 
    #to be false.
    Database.connection.execute("use mysqlquickbook")
   
    if !@error
    current_user.database.status = true
    current_user.database.save
    begin
      UserMailer.migration_done(current_user).deliver
    rescue => e
      logger.info "there are some errors while sending an email"
      logger.info e.inspect
      logger.info e.message
    end
    end
  end
  
  #in standard i want to integrate vendor customer and products
  
  
  def export_standard_migration(current_user)
    
    @error = false
    begin
      @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)


      logger.info "dbbbbbbbbbbbbbb       name     receiveddddddddddddddd s "
      logger.info dbname
      logger.info dbname
      logger.info dbname
      Database.connection.execute("use #{current_user.database.name}")
 
  
      logger.info "using above databaseeeeeeeee"
   
      logger.info "using above databaseeeeeeeee"

      logger.info "export_all_migration  model import.rbbbbbin import controllerrrr"
    	logger.info "Company calleddd"
			logger.info "Company....calleddd............"
	  	company = Company.all
    	logger.info "Company....calleddd......gettt......"
	    
    	Company.export_company(company,current_user)	
     
      logger.info "Account calleddd>>>>>>>>>>>>>>>>>"
      logger.info "Account calleddd>>>>>>>>>>>>>>>>>>"
      account = Account.all
  	  Account.export_account(account,current_user)
      logger.info "Account End>>>>>>>>>>>>>>>>>>"
  
      logger.info "Customer.....calleddd..........."
      custmr = Customer.find(:all)#Customer.all  
      Customer.call_customer_save(custmr,current_user)
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      #		  

      logger.info  "vendorr  ....................calleddd"
		  vendr = Vendor.find(:all)#,:limit=>10)#Vendor.all  
      Vendor.call_vendor_save(vendr,current_user)
	    #employee = #Employee.all
      employee = Employee.find(:all)
      
      #
      Employee.import_employee(employee,current_user)

      #what i need to here is keep an count whenever the count is greater than 50 then stop the migration.
      #how should i put a condition on 50 .first check Itemsalestax is more than 50 if yes then .
      #limit a 50 fetch it and import it.and exit it.if not then in its else part 
      #so whenever the limit is over then just return from a method.
      fifty_count = 50;
      #so when the fifty count is more than 50 return it
      #fifty_count = Itemsalestax.count   
       
      logger.info "the product count is started now1111"  
      logger.info  Itemsalestax.count
      #            7  
      if   Itemsalestax.count > 50
        itemsalestax = Itemsalestax.find(:all,:limit=>50)#Itemsalestax.all
        logger.info "ccccccccccccccccccccccccccc1111"
        Itemsalestax.export_item(itemsalestax,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemsalestax.count == 50
        itemsalestax = Itemsalestax.find(:all,:limit=>50)#Itemsalestax.all
        logger.info "ccccccccccccccccccccccccccc222"
        Itemsalestax.export_item(itemsalestax,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemsalestax = Itemsalestax.find(:all)#Itemsalestax.all
        logger.info "ccccccccccccccccccccccccccc333"
        Itemsalestax.export_item(itemsalestax,current_user)
        #Database.connection.execute("use mysqlquickbook")
           
      end
      
      logger.info "this is item sales tax import count"  
      logger.info Itemsalestax.count
      logger.info 
       
    
        
      fifty_count = fifty_count - Itemsalestax.count
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemsalestaxgroup.count
        
      if   Itemsalestaxgroup.count > fifty_count
        itemsalestg = Itemsalestaxgroup.find(:all,:limit=>fifty_count)
        Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemsalestaxgroup.count == fifty_count
        itemsalestg = Itemsalestaxgroup.find(:all,:limit=>fifty_count)
        Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemsalestg = Itemsalestaxgroup.find(:all)
        Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
        #Database.connection.execute("use mysqlquickbook")
           
      end
      
      fifty_count = fifty_count - Itemsalestaxgroup.count
        
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemservice.count  
        
        
        
      if   Itemservice.count > fifty_count
        itemserv = Itemservice.find(:all,:limit=>fifty_count)#Itemservice.all 
        Itemservice.export_itemservices(itemserv,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemservice.count == fifty_count
        itemserv = Itemservice.find(:all,:limit=>fifty_count)#Itemservice.all 
        Itemservice.export_itemservices(itemserv,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemserv = Itemservice.find(:all)#Itemservice.all 
        Itemservice.export_itemservices(itemserv,current_user)
        #Database.connection.execute("use mysqlquickbook")
             
      end
         
      fifty_count = fifty_count - Itemservice.count

      
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemdiscount.count  
        
        
        
      if   Itemdiscount.count > fifty_count
        itemdiscnt = Itemdiscount.find(:all,:limit=>fifty_count)#Itemdiscount.all
        Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemdiscount.count == fifty_count
        itemdiscnt = Itemdiscount.find(:all,:limit=>fifty_count)#Itemdiscount.all
        Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemdiscnt = Itemdiscount.find(:all)#Itemdiscount.all
        Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
        #Database.connection.execute("use mysqlquickbook")
	          
      end
         
      fifty_count = fifty_count - Itemdiscount.count
   
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemfixedasset.count 
        
        
      if   Itemfixedasset.count > fifty_count
        itemfixasset = Itemfixedasset.find(:all,:limit=>fifty_count)#Itemfixedasset.all 
        Itemfixedasset.export_itemfixassets(itemfixasset,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemfixedasset.count == fifty_count
        itemfixasset = Itemfixedasset.find(:all,:limit=>fifty_count)#Itemfixedasset.all 
        Itemfixedasset.export_itemfixassets(itemfixasset,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemfixasset = Itemfixedasset.find(:all)#Itemfixedasset.all 
        #here i need to add one more condition and that is suppose my fifty_count is 3 and model count is 7 
        #then it will come here.
        Itemfixedasset.export_itemfixassets(itemfixasset,current_user)
        #   Database.connection.execute("use mysqlquickbook")
 	           
      end
        
			fifty_count = fifty_count - Itemfixedasset.count
      
   
        
      if   Itemgroup.count > fifty_count
        itemgroup = Itemgroup.find(:all,:limit=>fifty_count)#Itemfixedasset.all 
        Itemgroup.export_itemgroups(itemgroup,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemgroup.count == fifty_count
        itemgroup = Itemgroup.find(:all,:limit=>fifty_count)#Itemfixedasset.all 
        Itemgroup.export_itemgroups(itemgroup,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        itemgroup = Itemgroup.find(:all)#Itemfixedasset.all 
        Itemgroup.export_itemgroups(itemgroup,current_user)
        #   Database.connection.execute("use mysqlquickbook")
 	           
      end
        
			fifty_count = fifty_count - Itemgroup.count
        
        
        
      
        
        
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Iteminventory.count
        
        
        
      if  Iteminventory.count > fifty_count
        iteminventory = Iteminventory.find(:all,:limit=>fifty_count)#Iteminventory.all
        Iteminventory.export_iteminventories(iteminventory,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Iteminventory.count == fifty_count
        iteminventory = Iteminventory.find(:all,:limit=>fifty_count)#Iteminventory.all
        Iteminventory.export_iteminventories(iteminventory,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        iteminventory = Iteminventory.find(:all)#Iteminventory.all
        Iteminventory.export_iteminventories(iteminventory,current_user)
        #  Database.connection.execute("use mysqlquickbook")
  	           
      end
        
      fifty_count = fifty_count - Iteminventory.count
      
        
        
        
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemnoninventory.count
        
        
      if  Itemnoninventory.count > fifty_count
        #here i need to check if remaining count is greater than 50 then get how much query i required to fire
        itemnoninventory = Itemnoninventory.find(:all,:limit=>fifty_count)#Itemnoninventory.all
        Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemnoninventory.count == fifty_count
        logger.info "zzzzzzzzzzzzzzz656565zzzielseifffff"
        itemnoninventory = Itemnoninventory.find(:all,:limit=>fifty_count)#Itemnoninventory.all
        Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        #else its assume here that its less than 50
        #if its come here then the remaining count is still less . so fire all the queries and then add the count to 
        #a model. 
        itemnoninventory = Itemnoninventory.find(:all)#Itemnoninventory.all
        Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
        logger.info "165165165161615"
      end
          
        
        
      
      fifty_count = fifty_count - Itemnoninventory.count
        
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemothercharge.count
      
        
         
        
        
        
      if Iteminventoryassembly.count > fifty_count
        iteminventoryassembly = Iteminventoryassembly.find(:all,:limit=>fifty_count)#Iteminventoryassembly.all    
        Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Iteminventoryassembly.count == fifty_count
        iteminventoryassembly = Iteminventoryassembly.find(:all,:limit=>fifty_count)
        Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        iteminventoryassembly = Iteminventoryassembly.find(:all)
        Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
	         
      end
        
        
        
      fifty_count = fifty_count - Iteminventoryassembly.count
        
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Iteminventoryassembly.count
      
        
        
        
        
        
        
      if  Itemothercharge.count > fifty_count
        #here i need to check if remaining count is greater than 50 then get how much query i required to fire
        itemothercharge = Itemothercharge.find(:all,:limit=>fifty_count)#Itemothercharge.all
        Itemothercharge.export_itemothercharge(itemothercharge,current_user)  
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      elsif Itemothercharge.count == fifty_count
        logger.info "zzzzzzzzzzzzzzzz5651651651zzielseifffff"
        itemothercharge = Itemothercharge.find(:all,:limit=>fifty_count)#Itemothercharge.all
        Itemothercharge.export_itemothercharge(itemothercharge,current_user)  
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        #else its assume here that its less than 50
        #if its come here then the remaining count is still less . so fire all the queries and then add the count to 
        #a model. 
        itemothercharge = Itemothercharge.find(:all)#Itemothercharge.all
        Itemothercharge.export_itemothercharge(itemothercharge,current_user)  
                  
      end
         
        
      fifty_count = fifty_count - Itemnoninventory.count
 
      logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Itemsubtotal.count
 
        
        	

      if Itempayment.count > fifty_count
        itempayment = Itempayment.find(:all,:limit=>fifty_count)#Itempayment.all 
        Itempayment.export_itempayment(itempayment,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
 
      elsif Itempayment.count == fifty_count
        itempayment = Itempayment.find(:all,:limit=>fifty_count)#Itempayment.all 
        Itempayment.export_itempayment(itempayment,current_user)
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
 
      else
        itempayment = Itempayment.find(:all,:limit=>fifty_count)#Itempayment.all 
        Itempayment.export_itempayment(itempayment,current_user)
  
      end
        
        
      fifty_count = fifty_count - Itempayment.count
          
      logger.info fifty_count
      logger.info Itempayment.count
      logger.info "888888888887452102"
 
        
        
        
        
      if  Itemsubtotal.count > fifty_count
        #here i need to check if remaining count is greater than 50 then get how much query i required to fire
             
        itemsubtotal = Itemsubtotal.find(:all,:limit=>fifty_count)#Itemsubtotal.all
        Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
          
        return
      elsif Itemsubtotal.count == fifty_count
        logger.info "zzzzzzzzzzzzzzzzzz6516161ielseifffff"
            
        itemsubtotal = Itemsubtotal.find(:all,:limit=>fifty_count)#Itemsubtotal.all
        Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
        Database.connection.execute("use mysqlquickbook")
        UserMailer.migration_done(current_user).deliver
        return
      else
        #else its assume here that its less than 50
        #if its come here then the remaining count is still less . so fire all the queries and then add the count to 
        #a model. 
        itemsubtotal = Itemsubtotal.find(:all)#Itemsubtotal.all
        Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
        logger.info "651616165161"
                   
      end
        
        
      Database.connection.execute("use mysqlquickbook")
      #this line is because in the above else there i did not written an connection back to original
      #database . and after this i am sending an email to user.
        
       
      
     
   
    rescue =>e
   
      logger.info "in rescue error occureddd"
      logger.info "ssssssssssssssssssssssssss"
      logger.info "in rescue error occureddd"
      logger.info e
      logger.info e.to_s
      logger.info e.message  
      logger.info e.backtrace.inspect 
    
      logger.info "connectinggggg to oct_4" 
      Database.connection.execute("use mysqlquickbook")
      @error = true
    end
    logger.info "connectinggggg to oct_4" 
    Database.connection.execute("use mysqlquickbook")
    if !@error
    current_user.database.status = true
    current_user.database.save
       begin
        UserMailer.migration_done(current_user).deliver
      rescue=>e
        logger.info "there are some errors while sending an email"
        logger.info e.inspect
        logger.info e.message
      end
    end

  end

  #in free now i need to limit the query to 10 users
  def export_free_migration(current_user)
    @error = false
    begin
      @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
      logger.info "dbbbbbbbbbbbbbb       name     receiveddddddddddddddd s "
      # logger.info dbname
      # logger.info dbname
      #logger.info dbname
      Database.connection.execute("use #{current_user.database.name}")
      logger.info "using above databaseeeeeeeee"
      logger.info "using above databaseeeeeeeee"
      logger.info "export_all_migration  model import.rbbbbbin import controllerrrr"
    	logger.info "Company calleddd"
			logger.info "Company....calleddd............"
	  	company = Company.all
    	logger.info "Company....calleddd......gettt......"
	    
    	Company.export_company(company,current_user)	
     
      logger.info "Account calleddd>>>>>>>>>>>>>>>>>"
      logger.info "Account calleddd>>>>>>>>>>>>>>>>>>"
      #account = Account.all
      #its because of its a free that is why instead of all the limit is of 10
      account = Account.find(:all,:limit=>10)
      logger.info "accounttttttttttttttttt"
      logger.info account.size
  	  Account.export_account(account,current_user)
      logger.info "Account End>>>>>>>>>>>>>>>>>>"
  
      logger.info "Customer.....calleddd..........."
      custmr = Customer.find(:all,:limit=>10)#Customer.all  
      Customer.call_customer_save(custmr,current_user)
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      #		  

      logger.info  "vendorr  ....................calleddd"
		  vendr = Vendor.find(:all,:limit=>10)#Vendor.all  
 	    Vendor.call_vendor_save(vendr,current_user)
	    employee = Employee.find(:all,:limit=>10)
      Employee.import_employee(employee,current_user)

   	  Database.connection.execute("use mysqlquickbook")
 
 
    
     
    rescue =>e
   
      logger.info "in rescue error occureddd"
      logger.info "ssssssssssssssssssssssssss"
      logger.info "in rescue error occureddd"
      logger.info e
      logger.info e.to_s
      logger.info e.message  
      logger.info e.backtrace.inspect 
    
      logger.info "connectinggggg to oct_4" 
      Database.connection.execute("use mysqlquickbook")
      @error = true
    end
    logger.info "connectinggggg to oct_4" 
    Database.connection.execute("use mysqlquickbook")
    
      if !@error
    current_user.database.status = true
    current_user.database.save
       begin
        UserMailer.migration_done(current_user).deliver
      rescue=>e
        logger.info "there are some errors while sending an email"
        logger.info e.inspect
        logger.info e.message
      end
    end
    

    
  end

  


end
