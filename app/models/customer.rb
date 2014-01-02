class Customer < ActiveRecord::Base
  #attr_accessible :ListID,:Mobile,:Contact,:FullName,:IsActive,:CreditLimit,:ParentRef_FullName,:BillAddress_Addr1,:BillAddress_Addr2,:BillAddress_Add3,:Salutation,:TimeModified
  self.table_name = "customer"

  def self.call_customer_save(custs,current_user)
   var = 1
   logger.info "all the customer counttttttttt"
   logger.info custs.count
   logger.info " call_customer save calleddd........."
    custs.each do |cust|
    logger.info "cdcdcdcdcdcdcdcdc"      
    logger.info var += 1
    logger.info "count is increased by 1"
    logger.info var
      old_res = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["quick_list_number","=",cust.ListID]])[0] 
      logger.info "swaxzswwwwwwwwwwwwwwww"
      logger.info old_res.inspect
      if old_res.blank?
         #if this is blank then it might happen that the customer is inactive 
         #so here i need to fire one more query to check wheather its inactive or not.
         oldresinact = eval(current_user.database.name.upcase.to_s)::ResPartner.find(:first, :domain=>[['quick_list_number','=',cust.ListID],['active','=',0]])
         logger.info "the customer id is blakkkkkkkkkkkkkkkkkkkk"
         if oldresinact.blank?
            self.common_customer_save(cust,current_user)
         else
            self.common_customer_save_update(cust,current_user,oldresinact.id)
         end
      else
           logger.info "already there and need a code for updation customer"
           #first time this should not come here
           logger.info old_res
           #here i will add one more condition and that is for update date time stamp. so if the date is not equal then 
           #call this method else skip this 
               logger.info "its because i got an quickbook idddddddd"
               #self.common_customer_save_update(cust,current_user,old_res)
      end
    
  end
    
 end

   def self.common_customer_save_update(cust,current_user,resparto)
         logger.info "this name is always get inserted123"
         
        logger.info cust.FullName
        
       respart =  eval(current_user.database.name.upcase.to_s)::ResPartner.find(resparto)
        datetimec = DateTime.new(cust.TimeModified.split(" ")[0].split("/")[2].to_i,cust.TimeModified.split(" ")[0].split("/")[0].to_i,cust.TimeModified.split(" ")[0].split("/")[1].to_i,cust.TimeModified.split(" ")[1].split(":")[0].to_i,cust.TimeModified.split(" ")[1].split(":")[1].to_i,cust.TimeModified.split(" ")[1].split(":")[2].to_i)
        logger.info "555555555555555555555555555555"     
        logger.info datetimec
       if respart.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
         logger.info "777777777777777777777777777777777777777777777777"
       respart.name = cust.Name
       respart.quick_list_number = cust.ListID
       
       respart.quickbook_time == datetimec
       respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
       respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
       respart.active = cust.IsActive
       oldrest = nil
      if cust.Salutation.blank?
        respart.title = nil
      else
           oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",cust.Salutation]])[0]
           if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = cust.Salutation
             newrest.name = cust.Salutation
              newrest.domain = "contact"
             newrest.save
             oldrest = newrest.id     
           end
          respart.title = oldrest     
       end 
      respart.credit_limit = cust.CreditLimit  
      respart.company_id = 1
       respart.customer = true
      respart.supplier = false
      respart.employee = false 
      if cust.ParentRef_FullName == nil
        respart.parent_id = nil
      else
        respart.parent_id = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["name","=",cust.ParentRef_FullName]])[0]   
      end   
            
      billingaddress = [cust.BillAddress_Addr1 , cust.BillAddress_Addr2, cust.BillAddress_Addr3,     cust.BillAddress_City,cust.BillAddress_PostalCode]
      shippingaddress = [cust.ShipAddress_Addr1 , cust.ShipAddress_Addr2,cust.ShipAddress_Addr3, cust.ShipAddress_City,cust.ShipAddress_PostalCode]
      logger.info "qwqwqwqwqwqwqwqwqwqw"
      if billingaddress
        logger.info "qaqaqaqaqaqaqaqaqaqa"
        respart.type = 'invoice'
        respart.name = cust.FullName
        respart.street = cust.BillAddress_Addr1
        respart.street2 = cust.BillAddress_Addr2.to_s + cust.BillAddress_Addr3.to_s + cust.BillAddress_Addr4.to_s
        respart.city = cust.BillAddress_City
        respart.zip = cust.BillAddress_PostalCode
        respart.active = cust.IsActive
        respart.title = oldrest
        respart.phone = cust.Phone
        respart.fax = cust.Fax
        respart.mobile = cust.Mobile
        respart.email = cust.Email
         logger.info "some errors while creating customer"
	      #logger.info respart.save
        logger.info "just see the example"
       # respart.save  
        logger.info "xsxsxsxsxsxsxsxsxsxsx"
        #respartadd.save
        logger.info "zazzazazazazazazazazaza"
      end  
      # as per priyanka i am commenting this because we will do this later so currently one customer will have 
      # one address only
      if shippingaddress  
        #i am copying here some code of the above for creating a new customer
         #respartn = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
         respart.name = cust.Name
         respart.quick_list_number = cust.ListID
         respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
         respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
         respart.active = cust.IsActive
       oldrestn = nil
      if cust.Salutation.blank?
        respart.title = nil
      else
           oldrestn = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",cust.Salutation]])[0]
           if oldrestn.blank?
             newrestn =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrestn.shortcut = cust.Salutation
             newrestn.name = cust.Salutation
              newrestn.domain = "contact"
             newrestn.save
             oldrestn = newrestn.id     
           end
          respart.title = oldrestn     
       end 
      respart.credit_limit = cust.CreditLimit  
      respart.company_id = 1
       respart.customer = true
      respart.supplier = false
      respart.employee = false 
      if cust.ParentRef_FullName == nil
        respart.parent_id = nil
      else
        respart.parent_id = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["name","=",cust.ParentRef_FullName]])[0]   
      end   
                
        #copy for customer shipping address is done here  
        respart.type = 'delivery'
        respart.name = cust.FullName
        respart.street = cust.ShipAddress_Addr1
        respart.street2 = cust.ShipAddress_Addr2.to_s + cust.ShipAddress_Addr3.to_s + cust.ShipAddress_Addr4.to_s
        respart.city = cust.ShipAddress_City
        respart.zip = cust.ShipAddress_PostalCode
        respart.active = cust.IsActive
        respart.title = oldrest
        respart.phone = cust.Phone
        respart.fax = cust.Fax
        respart.mobile = cust.Mobile
        respart.email = cust.Email
        logger.info "some errors while creating customer"
	     # logger.info respart.save
        logger.info "just see the example"
        logger.info "zazazazazazazazazaz"
      end  
      respart.save
       end
     
  end
  
  
  def self.common_customer_save(cust,current_user)
       logger.info "this name is always get inserted"
       logger.info cust.FullName
       respart = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
       respart.name = cust.Name
       respart.quick_list_number = cust.ListID
       #what i need to do is while saving an record also need to convert it into utc otherwise there is a time conflict
       de=DateTime.new(cust.TimeModified.split(" ")[0].split("/")[2].to_i,cust.TimeModified.split(" ")[0].split("/")[0].to_i,cust.TimeModified.split(" ")[0].split("/")[1].to_i,cust.TimeModified.split(" ")[1].split(":")[0].to_i,cust.TimeModified.split(" ")[1].split(":")[1].to_i,cust.TimeModified.split(" ")[1].split(":")[2].to_i)
       respart.quickbook_time = de
       logger.info "cust list id"
       logger.info cust.ListID
       respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
       respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
       respart.active = cust.IsActive
       oldrest = nil
      if cust.Salutation.blank?
        logger.info "salutation"
        respart.title = nil
      else
        logger.info "else salutation"
           oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",cust.Salutation]])[0]
           if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = cust.Salutation
             newrest.name = cust.Salutation
              newrest.domain = "contact"
             newrest.save
             oldrest = newrest.id     
           end
          respart.title = oldrest     
       end 
      respart.credit_limit = cust.CreditLimit  
      respart.company_id = 1
       respart.customer = true
      respart.supplier = false
      respart.employee = false 
      if cust.ParentRef_FullName == nil
        respart.parent_id = nil
      else
        respart.parent_id = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["name","=",cust.ParentRef_FullName]])[0]   
      end   
            
      billingaddress = [cust.BillAddress_Addr1 , cust.BillAddress_Addr2, cust.BillAddress_Addr3,     cust.BillAddress_City,cust.BillAddress_PostalCode]
      shippingaddress = [cust.ShipAddress_Addr1 , cust.ShipAddress_Addr2,cust.ShipAddress_Addr3, cust.ShipAddress_City,cust.ShipAddress_PostalCode]
      logger.info "qwqwqwqwqwqwqwqwqwqw"
      if billingaddress
        logger.info "qaqaqaqaqaqaqaqaqaqa"
        respart.type = 'invoice'
        respart.name = cust.FullName
        respart.street = cust.BillAddress_Addr1
        respart.street2 = cust.BillAddress_Addr2.to_s + cust.BillAddress_Addr3.to_s + cust.BillAddress_Addr4.to_s
        respart.city = cust.BillAddress_City
        respart.zip = cust.BillAddress_PostalCode
        respart.active = cust.IsActive
        respart.title = oldrest
        respart.phone = cust.Phone
        respart.fax = cust.Fax
        respart.mobile = cust.Mobile
        respart.email = cust.Email
         logger.info "some errors while creating customer"
	      #logger.info respart.save
        logger.info "just see the example"
       # respart.save  
        logger.info "xsxsxsxsxsxsxsxsxsxsx"
        #respartadd.save
        logger.info "zazzazazazazazazazazaza"
      end  
      # as per priyanka i am commenting this because we will do this later so currently one customer will have 
      # one address only
      if shippingaddress 
        logger.info "shipping address"
        #i am copying here some code of the above for creating a new customer
         #respartn = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
         respart.name = cust.Name
         respart.quick_list_number = cust.ListID
         respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
         respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
         respart.active = cust.IsActive
       oldrestn = nil
      if cust.Salutation.blank?
        respart.title = nil
      else
           oldrestn = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",cust.Salutation]])[0]
           if oldrestn.blank?
             newrestn =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrestn.shortcut = cust.Salutation
             newrestn.name = cust.Salutation
              newrestn.domain = "contact"
             newrestn.save
             oldrestn = newrestn.id     
           end
          respart.title = oldrestn     
       end 
      respart.credit_limit = cust.CreditLimit  
      respart.company_id = 1
       respart.customer = true
      respart.supplier = false
      respart.employee = false 
      if cust.ParentRef_FullName == nil
        respart.parent_id = nil
      else
        respart.parent_id = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["name","=",cust.ParentRef_FullName]])[0]   
      end   
                
        #copy for customer shipping address is done here  
        respart.type = 'delivery'
        respart.name = cust.FullName
        respart.street = cust.ShipAddress_Addr1
        respart.street2 = cust.ShipAddress_Addr2.to_s + cust.ShipAddress_Addr3.to_s + cust.ShipAddress_Addr4.to_s
        respart.city = cust.ShipAddress_City
        respart.zip = cust.ShipAddress_PostalCode
        respart.active = cust.IsActive
        respart.title = oldrest
        respart.phone = cust.Phone
        respart.fax = cust.Fax
        respart.mobile = cust.Mobile
        respart.email = cust.Email
        logger.info "some errors while creating customer"
	     # logger.info respart.save
        logger.info "just see the example"
        logger.info "zazazazazazazazazaz"
      end  
      logger.info "before saveeeeeeeeeeeee"
      logger.info respart.inspect
      respart.save
      logger.info respart.inspect
      
  end
  
  
  
end
