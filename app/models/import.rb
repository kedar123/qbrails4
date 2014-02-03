class Import < ActiveRecord::Base
  #attr_accessible :dbname, :password, :username
=begin  
  def self.when_to_run
    1.minute.from_now
  end

  def self.call_a_class_method
     
    logger.info "this should be printed"
    name = ['a','b','c','d','e','f','g','h','i','j']
    a=File.new(a[rand(8)].to_s+a[rand(8)].to_s+a[rand(8)].to_s+a[rand(8)].to_s+a[rand(8)].to_s+a[rand(8)].to_s, "w")
    a.write("test")
    a.close();

    
  
  end
  
  def self.start_a_method
    
    p Time.now
  handle_asynchronously :call_a_class_method, :run_at => Proc.new { when_to_run }
  
  end
  
 
  def call_start_import
          
    	logger.info "Company calleddd"
			logger.info "Company....calleddd............"
      
	  	company = Company.all
    	#Company.export_company(company)	

    	 
      custmr = Customer.all  
      #Customer.call_customer_save(custmr)
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
  		  
		  
		  

       
		  vendr = Vendor.all  
 	    #Vendor.call_vendor_save(vendr)
	    employee = Employee.all
      #Employee.import_employee(employee)

   	  logger.info "Account calleddd>>>>>>>>>>>>>>>>>"
	      
     # account = Account.all
  	 # Account.export_account(account)
 
      itemsalestax = Itemsalestax.all
      Itemsalestax.export_item(itemsalestax)
 
    
    
    
 		  logger.info "Itemservice calleddd"
			 
 	    itemserv = Itemservice.all 
  	  Itemservice.export_itemservices(itemserv)
 			logger.info "Itemdiscountttt......... calleddd"
 		
      p	"Itemdiscountttt......... calleddd"
			itemdiscnt = Itemdiscount.all
			Itemdiscount.export_itemdiscounts(itemdiscnt)
	
   		logger.info "Itemfixedasset................. calleddd"
		   p	"Itemfixedasset................. calleddd"
 			itemfixasset = Itemfixedasset.all 
   		Itemfixedasset.export_itemfixassets(itemfixasset)

 			logger.info "Itemgroup ........... calleddd"
		 
  		itemgroup = Itemgroup.all
 	 		Itemgroup.export_itemgroups(itemgroup)
			logger.info "Iteminventry.............. calleddd"
   		
 
      p	"Iteminventry.............. calleddd"
			iteminventory = Iteminventory.all
	    Iteminventory.export_iteminventories(iteminventory)
			logger.info "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
			
      p	 "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
			itemnoninventory = Itemnoninventory.all
			Itemnoninventory.export_itemnoninventory(itemnoninventory)
			logger.info "Iteminventoryassembly................... calleddd"
 			
      
			iteminventoryassembly = Iteminventoryassembly.all      
 			Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly)
			logger.info "Itemmothercharge.................. calleddd"
 			
       
 			itemothercharge = Itemothercharge.all
			Itemothercharge.export_itemothercharge(itemothercharge)
    	logger.info "Itempaymentt.................. calleddd"
  		
   
       
  	  itempayment = Itempayment.all 
 			Itempayment.export_itempayment(itempayment)
			logger.info "ItemService................... calleddd"
			 
 			
    	itemserv = Itemservice.all
   		Itemservice.export_itemservices(itemserv)
			logger.info "all data migrated........."
       
      itemsubtotal = Itemsubtotal.all
      Itemsubtotal.export_itemsubtotal(itemsubtotal) 	
      
    
      logger.info "Bill migrating............ calleddd"
       
  	  bill = Bill.all  #vendor run first
	    Bill.export_bill(bill)

    
    
       
    	purorder = Purchaseorder.all
  		purorlndetail = Purchaseorderlinedetail.all
  		Purchaseorder.export_purchaseorder(purorder,purorlndetail)
    
      
 			salesorder = Salesorder.all
 			soldetails = Salesorderlinedetails.all
 			Salesorder.export_salesorder(salesorder, soldetails)
    
      
			invoice = Invoice.all
      invoicelinedetail = Invoicelinedetail.all
			Invoice.export_invoice(invoice,invoicelinedetail)
  		 

  end
 
  def self.export_all_migration(dbname,current_user)
  begin
  @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":8069/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)


   
   p dbname
   p dbname
   p dbname
    Database.connection.execute("use #{current_user.database.name}")
 
  
     
   
    logger.info "using above databaseeeeeeeee"

       
    	logger.info "Company calleddd"
			logger.info "Company....calleddd............"
	  	company = Company.all
    	logger.info "Company....calleddd......gettt......"
	    
    	Company.export_company(company,current_user)	
     
 
    	 
     # custmr = Customer.all  
     # Customer.call_customer_save(custmr,current_user)
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		  
#		  

      p 	"vendorr  ....................calleddd"
		 # vendr = Vendor.all  
 	   # Vendor.call_vendor_save(vendr,current_user)
	   # employee = Employee.all
     # Employee.import_employee(employee,current_user)

   	  logger.info "Account calleddd>>>>>>>>>>>>>>>>>"
	     
      account = Account.all
  	  Account.export_account(account,current_user)
# 

 	    logger.info "Bill migrating............ calleddd"
    	 
  	  bill = Bill.all  #vendor run first
	    Bill.export_bill(bill,current_user)
		  logger.info "Itemservice calleddd"
#			 
 	    itemserv = Itemservice.all 
  	  Itemservice.export_itemservices(itemserv,current_user)
 			logger.info "Itemdiscountttt......... calleddd"
# 		
#       
			itemdiscnt = Itemdiscount.all
			Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
#	
#   		logger.info "Itemfixedasset................. calleddd"
#		   
 			itemfixasset = Itemfixedasset.all 
   		Itemfixedasset.export_itemfixassets(itemfixasset,current_user)


# 			logger.info "Itemgroup ........... calleddd"
#			 
  		itemgroup = Itemgroup.all
 	 		Itemgroup.export_itemgroups(itemgroup,current_user)
#			logger.info "Iteminventry.............. calleddd"
#   		
# 
#      
			iteminventory = Iteminventory.all
	    Iteminventory.export_iteminventories(iteminventory,current_user)
			logger.info "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
#			
#       
			itemnoninventory = Itemnoninventory.all
			Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
			logger.info "Iteminventoryassembly................... calleddd"
# 			
#       
			iteminventoryassembly = Iteminventoryassembly.all      
 			Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
			logger.info "Itemmothercharge.................. calleddd"
# 			
#      
 			itemothercharge = Itemothercharge.all
			Itemothercharge.export_itemothercharge(itemothercharge,current_user)
    	logger.info "Itempaymentt.................. calleddd"
#  		
#   
#       
  	  itempayment = Itempayment.all 
 			Itempayment.export_itempayment(itempayment,current_user)
			logger.info "ItemService................... calleddd"
			 
 
      itemsubtotal = Itemsubtotal.all
      Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 	
#      
#       
    	purorder = Purchaseorder.all
  		Purchaseorder.export_purchaseorder(purorder,current_user)
#    
#       
 			salesorder = Salesorder.all
 			Salesorder.export_salesorder(salesorder,current_user)
#    
     	 
			invoice = Invoice.all
      Invoice.export_invoice(invoice,current_user)
  rescue =>e
   
     
  
    logger.info "in rescue error occureddd"
    logger.info e
    logger.info e.to_s
    logger.info e.message  
    logger.info e.backtrace.inspect 
    
    
   Database.connection.execute("use oct_4")
   
  end
    
   Database.connection.execute("use oct_4")
 end
  
=end

  # need to devide the things in basic i will have customer and vendor
  # in standard i have customer vendor and products
  # in all migration i have bill and invoice addedd
  
  #this will export all the data
  
  def export_testupdate_migration(current_user)
   @error = false
   @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
   logger.info "dbbbbbbbbbbbbbb       name     receiveddddddddddddddd s "
   logger.info dbname
   logger.info dbname
   logger.info dbname
    Database.connection.execute("use #{current_user.database.name}")
#    account = Account.all
#    count = 0
#      account.each do |item|
   # begin
#   logger.info "creatinfg salesorder itemsssssssssssssssssss"
#        oldac =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["code","=",item.AccountNumber]])[0]
#    count = count + 1
#    if  oldac.blank?
#      logger.info "this account is not yet created"
#      logger.info item.AccountNumber
#    else
#      logger.info "the account is created"
#      logger.info item.AccountNumber
#    end
#    end
#   logger.info  count
#   logger.info "the count is same or not"
  
  #  custmr = Customer.find(:all)#,:limit=>10)#Customer.all  
    
  #   custmr.each do |cust|
  #   old_res = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["name","=",cust.Name]])[0] 
  #    if old_res.blank?
  #      logger.info "customer is not get inserted"
  #      logger.info cust.Name
  #    else
  #      logger.info "customer is get inserted"
  #     end
   #  end
   
   # 	iteminventory = Iteminventory.find(:all)#Iteminventory.all
	 #  Iteminventory.export_iteminventories(iteminventory,current_user)
    
#    iteminventoryassembly = Iteminventoryassembly.find(:all)#Iteminventoryassembly.all      
# 			Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)

   #  bill = Bill.find(:all)#Bill.all  #vendor run first
	 #  Bill.export_bill(bill,current_user)
  #   	purorder = Purchaseorder.find(:all)#Purchaseorder.all
  #	Purchaseorder.export_purchaseorder(purorder,current_user)
#	salesorder = Salesorder.find(:all)#Salesorder.all
# 	Salesorder.export_salesorder(salesorder,current_user)
#	invoice = Invoice.find(:all)#Invoice.all
#  logger.info "i got the invoiceeee"
#  logger.info invoice
  
#  Invoice.export_invoice(invoice,current_user)

#     creditmemo = Creditmemo.all    
#     Creditmemo.export_credit_memo(creditmemo,current_user)   
   
#      cashbackinfo = Cashbackinfodetail.all
#      Cashbackinfodetail.export_cashbackinfodetail(cashbackinfo, current_user)
 
 #    esti = Estimate.all 
 #     logger.info "no twoooo"
 #     Estimate.export_estimate(esti,current_user)
 # this estimates need some modification in code
 
    
    
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

      iteminventoryassembly = Iteminventoryassembly.find(:all)
      Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
	  
      
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
      
      #this table is not required because its item is for just to know a quantity there reference is from 
      #iteminventory table as well as from iteminventoryassembly table.
      #iteminvassmlindet = Iteminventoryassemblylinedetail.find(:all)
      #Iteminventoryassemblylinedetail.export_iteminventoryaseemblilinedetail(iteminvassmlindet,current_user)

  	#  bill = Bill.find(:all)#Bill.all  #vendor run first
	  #  Bill.export_bill(bill,current_user)
      logger.info "sales receipt is done"
      
     	logger.info "invoice called ....successfullyyyyyyyyy.."
		#	invoice = Invoice.find(:all)#Invoice.all
     # Invoice.export_invoice(invoice,current_user)
 
=begin  
    logger.info "using above databaseeeeeeeee"
   
    logger.info "using above databaseeeeeeeee"

      logger.info "export_all_migration  model import.rbbbbbin import controllerrrr"
    	logger.info "Company calleddd"
			logger.info "Company....calleddd............"
 
      company = Company.find(:all)
    	Company.export_company(company,current_user)	
     
      logger.info "Account calleddd>>>>>>>>>>>>>>>>>"
	     logger.info "Account calleddd>>>>>>>>>>>>>>>>>>"
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
      
      #this table is not required because its item is for just to know a quantity there reference is from 
      #iteminventory table as well as from iteminventoryassembly table.
      iteminvassmlindet = Iteminventoryassemblylinedetail.find(:all)
      Iteminventoryassemblylinedetail.export_iteminventoryaseemblilinedetail(iteminvassmlindet,current_user)
      
       
      
#      
#     
#      logger.info "Bill migrating............ calleddd"
    	 logger.info "Bill migrating............ calleddd8944849648"
  	  bill = Bill.find(:all)#Bill.all  #vendor run first
	    Bill.export_bill(bill,current_user)
#       
#          
     purorder = Purchaseorder.find(:all)#Purchaseorder.all
     logger.info "Bill migrating............ calleddd555555"
  	 Purchaseorder.export_purchaseorder(purorder,current_user)

      
#    
#      
 			salesorder = Salesorder.find(:all)#Salesorder.all
 			Salesorder.export_salesorder(salesorder,current_user)
#   

      logger.info "sales receiptttttt"
      salesrec = Salesreceipt.find(:all)
      #no uniqueness is checked
     #Salesreceipt.export_salesreceipt(salesrec,current_user)
      #calling receive paymentttt
     logger.info "calling receive paymentsss" 
     recivpay = Receivepayment.find(:all)
     #Receivepayment.call_receive_payment_save(recivpay,current_user)
      
      
      logger.info "sales receipt is done"
      
     	logger.info "invoice called ....successfullyyyyyyyyy.."
			invoice = Invoice.find(:all)#Invoice.all
      Invoice.export_invoice(invoice,current_user)
      
  
      journalentry = Journalentry.find(:all)
      #Journalentry.export_journal_entry(journalentry,current_user)
      logger.info "sswwswcsdcsdcscsczcxcdfvfdv"
      jcrdt = Journalcreditdetail.all
      #Journalcreditdetail.export_journalcreditdetail(jcrdt,current_user)
      jdrdt = Journaldebitdetail.all
      logger.info "dscgvdscgvhsgcvhgv"
      #Journaldebitdetail.export_journaldebitdetail(jdrdt,current_user)
      logger.info "gdhcvbsdvgcdvcsdgvc"
      logger.info "calling the deposit"
      deposit = Deposit.all
      #Deposit.export_deposit(deposit, current_user)
      logger.info "deposit completes"
      logger.info "deposit line detail started"
      
      depolidet = Depositlinedetail.all
      #Depositlinedetail.export_depositlinedetail(depolidet,current_user)
      

       logger.info "this is credit memossss7"
      creditmemo = Creditmemo.all    
      Creditmemo.export_credit_memo(creditmemo,current_user)   
      logger.info "all about credit memo complete"    
      
 

      logger.info "cashbackinfodetail"
      cashbackinfo = Cashbackinfodetail.all
      Cashbackinfodetail.export_cashbackinfodetail(cashbackinfo, current_user)

      logger.info "no oneeee"
      esti = Estimate.all 
      logger.info "no twoooo"
      Estimate.export_estimate(esti,current_user)
      logger.info "no threeee"
     
         logger.info "no threeee"
      logger.info "i am making a charge"
      charge = Charge.all
      Charge.export_charge(charge,current_user)
       
      logger.info "this is for check "
      check = Check.all
      #Check.export_check(check,current_user)
      
      logger.info "starting the item receipt"
      itemreceipt = Itemreceipt.all
      Itemreceipt.export_itemreceipt(itemreceipt,current_user)
=end      
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
   current_user.database.status = true
   current_user.database.save
  if @error
    raise "Error"
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
     # Customer.call_customer_save(custmr,current_user)
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
		  logger.info "Customer Ended>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
#		  

      logger.info  "vendorr  ....................calleddd"
		  vendr = Vendor.find(:all)#,:limit=>10)#Vendor.all  
 	   #Vendor.call_vendor_save(vendr,current_user)
	    #employee = #Employee.all
      employee = Employee.find(:all)
      
      #
     #Employee.import_employee(employee,current_user)

   	 #what i need to here is keep an count whenever the count is greater than 50 then stop the migration.
     #how should i put a condition on 50 .first check Itemsalestax is more than 50 if yes then .
     #limit a 50 fetch it and import it.and exit it.if not then in its else part 
     #so whenever the limit is over then just return from a method.
      fifty_count = 50;
      #so when the fifty count is more than 50 return it
      #fifty_count = Itemsalestax.count   
       
      logger.info "the product count is started now1111"  
      logger.info  Itemsalestax.count
      
      if   Itemsalestax.count > 50
              itemsalestax = Itemsalestax.find(:all,:limit=>50)#Itemsalestax.all
              logger.info "ccccccccccccccccccccccccccc1111"
              Itemsalestax.export_item(itemsalestax,current_user)
              Database.connection.execute("use mysqlquickbook")
           return
      elsif Itemsalestax.count == 50
                itemsalestax = Itemsalestax.find(:all,:limit=>50)#Itemsalestax.all
              logger.info "ccccccccccccccccccccccccccc222"
              Itemsalestax.export_item(itemsalestax,current_user)
              Database.connection.execute("use mysqlquickbook")
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
           return
      elsif Itemsalestaxgroup.count == fifty_count
           itemsalestg = Itemsalestaxgroup.find(:all,:limit=>fifty_count)
           Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
           Database.connection.execute("use mysqlquickbook")
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
            return
      elsif Itemservice.count == fifty_count
        itemserv = Itemservice.find(:all,:limit=>fifty_count)#Itemservice.all 
  	       Itemservice.export_itemservices(itemserv,current_user)
           Database.connection.execute("use mysqlquickbook")
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
	           return
      elsif Itemdiscount.count == fifty_count
         itemdiscnt = Itemdiscount.find(:all,:limit=>fifty_count)#Itemdiscount.all
			    Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
          Database.connection.execute("use mysqlquickbook")
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
 	           return
      elsif Itemfixedasset.count == fifty_count
              	itemfixasset = Itemfixedasset.find(:all,:limit=>fifty_count)#Itemfixedasset.all 
       		      Itemfixedasset.export_itemfixassets(itemfixasset,current_user)
                Database.connection.execute("use mysqlquickbook")
 	           return
      else
              	itemfixasset = Itemfixedasset.find(:all)#Itemfixedasset.all 
       		      Itemfixedasset.export_itemfixassets(itemfixasset,current_user)
             #   Database.connection.execute("use mysqlquickbook")
 	           
      end
        
			fifty_count = fifty_count - Itemfixedasset.count
      
  
        
     logger.info "this is itemsalestaxgroup"
      logger.info fifty_count
      logger.info Iteminventory.count
        
        
        
       if  Iteminventory.count > fifty_count
            			iteminventory = Iteminventory.find(:all,:limit=>fifty_count)#Iteminventory.all
	              Iteminventory.export_iteminventories(iteminventory,current_user)
                Database.connection.execute("use mysqlquickbook")
  	           return
       elsif Iteminventory.count == fifty_count
            			iteminventory = Iteminventory.find(:all,:limit=>fifty_count)#Iteminventory.all
	              Iteminventory.export_iteminventories(iteminventory,current_user)
                Database.connection.execute("use mysqlquickbook")
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
		            return
          elsif Itemnoninventory.count == fifty_count
              logger.info "zzzzzzzzzzzzzzz656565zzzielseifffff"
                	itemnoninventory = Itemnoninventory.find(:all,:limit=>fifty_count)#Itemnoninventory.all
			         Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
               Database.connection.execute("use mysqlquickbook")
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
	             return
         elsif Iteminventoryassembly.count == fifty_count
           iteminventoryassembly = Iteminventoryassembly.find(:all,:limit=>fifty_count)
                Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
                Database.connection.execute("use mysqlquickbook")
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
                 return
      elsif Itemothercharge.count == fifty_count
           logger.info "zzzzzzzzzzzzzzzz5651651651zzielseifffff"
           itemothercharge = Itemothercharge.find(:all,:limit=>fifty_count)#Itemothercharge.all
			    Itemothercharge.export_itemothercharge(itemothercharge,current_user)  
          Database.connection.execute("use mysqlquickbook")
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
                return
 
        elsif Itempayment.count == fifty_count
                itempayment = Itempayment.find(:all,:limit=>fifty_count)#Itempayment.all 
 	            	Itempayment.export_itempayment(itempayment,current_user)
                Database.connection.execute("use mysqlquickbook")
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
          
                 return
      elsif Itemsubtotal.count == fifty_count
           logger.info "zzzzzzzzzzzzzzzzzz6516161ielseifffff"
            
         itemsubtotal = Itemsubtotal.find(:all,:limit=>fifty_count)#Itemsubtotal.all
         Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
    Database.connection.execute("use mysqlquickbook")
               return
      else
        #else its assume here that its less than 50
        #if its come here then the remaining count is still less . so fire all the queries and then add the count to 
        #a model. 
          itemsubtotal = Itemsubtotal.find(:all)#Itemsubtotal.all
         Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
         logger.info "651616165161"
                   
       end
        
        
         
        
       
      
     # iteminvassmlindet = Iteminventoryassemblylinedetail.find(:all)
      logger.info "the iteminventoryassemblylinedetails"
      #logger.info iteminvassmlindet.size
       
      #this table is not required because its item is for just to know a quantity there reference is from 
      #iteminventory table as well as from iteminventoryassembly table.
      # Iteminventoryassemblylinedetail.export_iteminventoryaseemblilinedetail(iteminvassmlindet,current_user)
      #the Iteminventoryassemblylinedetail table is not really required to migrate because the items are already get migrated
      #in the openerp as its here just a reference with listid.
      
            
#      logger.info "Bill migrating............ calleddd"
    	 logger.info "Bill migrating............ calleddd"
  	 # bill = Bill.find(:all)#Bill.all  #vendor run first
	 # Bill.export_bill(bill,current_user)
#       
#          
    #	purorder = Purchaseorder.find(:all)#Purchaseorder.all
  	#Purchaseorder.export_purchaseorder(purorder,current_user)
#    
#       
 		#	salesorder = Salesorder.find(:all)#Salesorder.all
 	#		Salesorder.export_salesorder(salesorder,current_user)
#    
 #     logger.info "sales receiptttttt"
    #  salesrec = Salesreceipt.find(:all)
      #no uniqueness is checked
  #   Salesreceipt.export_salesreceipt(salesrec,current_user)
      #calling receive paymentttt
 #    logger.info "calling receive paymentsss" 
   #  recivpay = Receivepayment.find(:all)
  #   Receivepayment.call_receive_payment_save(recivpay,current_user)
      
      
 #     logger.info "sales receipt is done"
      
 #    	logger.info "invoice called ....successfullyyyyyyyyy.."
#			invoice = Invoice.find(:all)#Invoice.all
   #   Invoice.export_invoice(invoice,current_user)
      
      
#      journalentry = Journalentry.find(:all)
      #Journalentry.export_journal_entry(journalentry,current_user)
#      logger.info "sswwswcsdcsdcscsczcxcdfvfdv"
#      jcrdt = Journalcreditdetail.all
      #Journalcreditdetail.export_journalcreditdetail(jcrdt,current_user)
#      jdrdt = Journaldebitdetail.all
#      logger.info "dscgvdscgvhsgcvhgv"
      #Journaldebitdetail.export_journaldebitdetail(jdrdt,current_user)
#      logger.info "gdhcvbsdvgcdvcsdgvc"
#      logger.info "calling the deposit"
#      deposit = Deposit.all
      #Deposit.export_deposit(deposit, current_user)
#      logger.info "deposit completes"
#      logger.info "deposit line detail started"
      
#      depolidet = Depositlinedetail.all
      #Depositlinedetail.export_depositlinedetail(depolidet,current_user)
      

#       logger.info "this is credit memossss7"
#      creditmemo = Creditmemo.all    
#      Creditmemo.export_credit_memo(creditmemo,current_user)   
#      logger.info "all about credit memo complete"    
      


#      logger.info "cashbackinfodetail"
#      cashbackinfo = Cashbackinfodetail.all
#      Cashbackinfodetail.export_cashbackinfodetail(cashbackinfo, current_user)
#        logger.info "no oneeee"
#      esti = Estimate.all 
#      logger.info "no twoooo"
#      Estimate.export_estimate(esti,current_user)
#      logger.info "no threeee"
      
#         logger.info "no threeee"
#      logger.info "i am making a charge"
#      charge = Charge.all
#      Charge.export_charge(charge,current_user)
#      logger.info "this is for check "
#      check = Check.all
#      Check.export_check(check,current_user)
      
#      logger.info "starting the item receipt"
#      itemreceipt = Itemreceipt.all
#      Itemreceipt.export_itemreceipt(itemreceipt,current_user)
#and lastly from here i need to send an email   
begin
    UserMailer.migration_done(current_user).deliver
    rescue=>e
      logger.info "there are some errors while sending an email"
      logger.info e.inspect
      logger.info e.message
    end
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
   current_user.database.status = true
   current_user.database.save
  if @error
    raise "Error"
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

   	  
 
#       logger.info "zzzzzzzzzzzzzzzzzz"
      itemsalestax = Itemsalestax.find(:all)#Itemsalestax.all
      logger.info "ccccccccccccccccccccccccccc"
 #     Itemsalestax.export_item(itemsalestax,current_user)
 
# 	    logger.info "item sales tax group"
      itemsalestg = Itemsalestaxgroup.find(:all)
  #    Itemsalestaxgroup.export_itemsalestgr(itemsalestg,current_user) 
      
      
      
      
#		  logger.info "Itemservice calleddd"
#logger.info "Itemservice calleddd"
 	    itemserv = Itemservice.find(:all)#Itemservice.all 
 # 	 Itemservice.export_itemservices(itemserv,current_user)
# 			logger.info "Itemdiscountttt......... calleddd"
# 		
#logger.info	"Itemdiscountttt......... calleddd"
			itemdiscnt = Itemdiscount.find(:all)#Itemdiscount.all
#			Itemdiscount.export_itemdiscounts(itemdiscnt,current_user)
#	
#   		logger.info "Itemfixedasset................. calleddd"
#logger.info	"Itemfixedasset................. calleddd"
 			itemfixasset = Itemfixedasset.find(:all)#Itemfixedasset.all 
 #  		Itemfixedasset.export_itemfixassets(itemfixasset,current_user)


# 			logger.info "Itemgroup ........... calleddd"
#logger.info "Itemgroup ........... calleddd"
  		itemgroup = Itemgroup.find(:all)#Itemgroup.all
 	# 		Itemgroup.export_itemgroups(itemgroup,current_user)#
#			logger.info "Iteminventry.............. calleddd"
#   		
# 
#logger.info	"Iteminventry.............. calleddd"
			iteminventory = Iteminventory.find(:all)#Iteminventory.all
	#   Iteminventory.export_iteminventories(iteminventory,current_user)
#			logger.info "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
#			
#logger.info	 "Itemsnoninventory,,,,,,,,,,,,,,,,,,,, calleddd"
			itemnoninventory = Itemnoninventory.find(:all)#Itemnoninventory.all
	#		Itemnoninventory.export_itemnoninventory(itemnoninventory,current_user)
#			logger.info "Iteminventoryassembly................... calleddd"
# 			
#       
			iteminventoryassembly = Iteminventoryassembly.find(:all)#Iteminventoryassembly.all      
 	#		Iteminventoryassembly.export_iteminventoryaseemblies(iteminventoryassembly,current_user)
	#		logger.info "Itemmothercharge.................. calleddd"
# 			
#       
 			itemothercharge = Itemothercharge.find(:all)#Itemothercharge.all
	#		Itemothercharge.export_itemothercharge(itemothercharge,current_user)
 #   	logger.info "Itempaymentt.................. calleddd"
#  		
#   
#       
  	  itempayment = Itempayment.find(:all)#Itempayment.all 
 	#		Itempayment.export_itempayment(itempayment,current_user)
#			logger.info "ItemService................... calleddd"#
#			logger.info "ItemService................... calleddd"
 
      itemsubtotal = Itemsubtotal.find(:all)#Itemsubtotal.all
   #   Itemsubtotal.export_itemsubtotal(itemsubtotal,current_user) 
      
      #this table is not required because its item is for just to know a quantity there reference is from 
      #iteminventory table as well as from iteminventoryassembly table.
      #iteminvassmlindet = Iteminventoryassemblylinedetail.find(:all)
      #Iteminventoryassemblylinedetail.export_iteminventoryaseemblilinedetail(iteminvassmlindet,current_user)
      #as this is not required to import because this items are already get imported through previous tables and here its
      #just a reference of it.
      
      
#      
#     
#      logger.info "Bill migrating............ calleddd"
 #   	 logger.info "Bill migrating............ calleddd"
  	 # bill = Bill.find(:all)#Bill.all  #vendor run first
#	   Bill.export_bill(bill,current_user)
#       
#          
    #	purorder = Purchaseorder.find(:all)#Purchaseorder.all
 # 	Purchaseorder.export_purchaseorder(purorder,current_user)
#    
#       
 	#		salesorder = Salesorder.find(:all)#Salesorder.all
 #			Salesorder.export_salesorder(salesorder,current_user)
#    
#      logger.info "sales receiptttttt"
#      salesrec = Salesreceipt.find(:all)
      #no uniqueness is checked
     #Salesreceipt.export_salesreceipt(salesrec,current_user)
      #calling receive paymentttt
#     logger.info "calling receive paymentsss" 
 #    recivpay = Receivepayment.find(:all)
     #Receivepayment.call_receive_payment_save(recivpay,current_user)
      
      
 #     logger.info "sales receipt is done"
      
 #    	logger.info "invoice called ....successfullyyyyyyyyy.."
#			invoice = Invoice.find(:all)#Invoice.all
#      Invoice.export_invoice(invoice,current_user)
      
      
 #     journalentry = Journalentry.find(:all)
      #Journalentry.export_journal_entry(journalentry,current_user)
 #     logger.info "sswwswcsdcsdcscsczcxcdfvfdv"
 #     jcrdt = Journalcreditdetail.all
      #Journalcreditdetail.export_journalcreditdetail(jcrdt,current_user)
 #     jdrdt = Journaldebitdetail.all
 #     logger.info "dscgvdscgvhsgcvhgv"
      #Journaldebitdetail.export_journaldebitdetail(jdrdt,current_user)
 #     logger.info "gdhcvbsdvgcdvcsdgvc"
 #     logger.info "calling the deposit"
 #     deposit = Deposit.all
      #Deposit.export_deposit(deposit, current_user)
 #     logger.info "deposit completes"
 #     logger.info "deposit line detail started"
      
 #     depolidet = Depositlinedetail.all
      #Depositlinedetail.export_depositlinedetail(depolidet,current_user)
      

 #      logger.info "this is credit memossss7"
 #     creditmemo = Creditmemo.all    
 #     Creditmemo.export_credit_memo(creditmemo,current_user)   
 #     logger.info "all about credit memo complete"    
      


 #     logger.info "cashbackinfodetail"
 #     cashbackinfo = Cashbackinfodetail.all
 #     Cashbackinfodetail.export_cashbackinfodetail(cashbackinfo, current_user)
 #       logger.info "no oneeee"
 #     esti = Estimate.all 
 #     logger.info "no twoooo"
 #     Estimate.export_estimate(esti,current_user)
 #     logger.info "no threeee"
      
 #        logger.info "no threeee"
 #     logger.info "i am making a charge"
 #     charge = Charge.all
 #     Charge.export_charge(charge,current_user)
  #    logger.info "this is for check "
 #     check = Check.all
 #     Check.export_check(check,current_user)
      
 #     logger.info "starting the item receipt"
 #     itemreceipt = Itemreceipt.all
 #     Itemreceipt.export_itemreceipt(itemreceipt,current_user)
    begin
      UserMailer.migration_done(current_user).deliver
    rescue=>e
      logger.info "there are some errors while sending an email this error is might be because the smtp configuration is wrongly given"
      logger.info e.inspect
      logger.info e.message
    end
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
   current_user.database.status = true
   current_user.database.save
  if @error
    raise "Error"
  end 
    

    
 end

  


end
