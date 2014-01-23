class Vendor < ActiveRecord::Base
  #attr_accessible :Mobile,:Contact,:FullName,:IsActive,:CreditLimit,:ParentRef_FullName,:BillAddress_Addr1,:BillAddress_Addr2,:BillAddress_Add3,:Salutation

  self.table_name = "vendor"

  def self.call_vendor_save(vndr,current_user)
     
    ver = 1
    vndr.each do |vender|
      begin
       
     logger.info ver+= 1
     logger.info "variable record>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
     
     logger.info ver += 1 
     logger.info "in vend or do........"
      
      old_res = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["quick_list_number","=",vender.ListID]])[0] 
      logger.info old_res
      logger.info "45451321584874874964"
       if old_res.blank?
          logger.info "222222222222224444444444444"
           oldresinact = eval(current_user.database.name.upcase.to_s)::ResPartner.find(:first, :domain=>[['quick_list_number','=',vender.ListID],['active','=',0]])
             if oldresinact.blank?
               self.common_vendor_save(current_user,vender)
             else
               self.common_vendor_update(current_user,old_res,oldresinact.id)
             end
        else 
          logger.info "updateeee8888888888"
              # self.common_vendor_update(current_user,old_res,vender)
        end
     
    rescue => e
      logger.info "vendor error msg"
      logger.info e.message
    end
       
    end
  end
  
  
  
  def self.common_vendor_update(current_user,venderid,vender)
       logger.info "i am blank888888888888888888"
      respart = eval(current_user.database.name.upcase.to_s)::ResPartner.find(venderid)
      
    
    
     datetimec = DateTime.new(vender.TimeModified.split(" ")[0].split("/")[2].to_i,vender.TimeModified.split(" ")[0].split("/")[0].to_i,vender.TimeModified.split(" ")[0].split("/")[1].to_i,vender.TimeModified.split(" ")[1].split(":")[0].to_i,vender.TimeModified.split(" ")[1].split(":")[1].to_i,vender.TimeModified.split(" ")[1].split(":")[2].to_i)
        logger.info "555555555555555555555555555555"     
        logger.info datetimec
       if respart.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
    
           logger.info "4111111111111111111111"
    
    
      respart.name = vender.Name
      respart.type = 'default'
      respart.customer = false
      respart.supplier = true  
      respart.employee = false
      respart.active =  vender.IsActive 
      respart.quick_list_number = vender.ListID
      respart.quickbook_time = datetimec
      #if  vender.CompanyName.blank?
      #  respart.company_id = nil
      #else
      #  respart.company_id = eval(current_user.database.name.upcase.to_s)::ResCountry.search([["name","=",vender.CompanyName]])[0] 
        
     # end     
     respart.company_id = 1
     oldrest = nil
     
      respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
      if vender.Salutation.blank?
        respart.title = nil
      else
        oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",vender.Salutation]])[0]
          
          
          
          if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = vender.Salutation
             newrest.name = vender.Salutation
              
             newrest.domain = "contact"
             newrest.save
             oldrest = newrest.id     
           
          end
          respart.title = oldrest     
      end
       
        
      

     # respartadd = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.new
     # respartadd.partner_id = respart.id 
      respart.type = 'default'
      respart.name = vender.Name
      respart.street = vender.VendorAddress_Addr2
      respart.street2 = vender.VendorAddress_Addr3
      respart.city = vender.VendorAddress_City
      respart.zip = vender.VendorAddress_PostalCode
      respart.phone = vender.Phone
      respart.mobile = vender.Mobile
      respart.fax = vender.Fax
      respart.email = vender.Email
      respart.title = oldrest
      respart.active =  vender.IsActive 
      
      #respart.save
       
      logger.info "from vendor save"
     # logger.info vender.Name
     # logger.info  respartadd.save
     # logger.info respartadd.id
      #else
        logger.info "already inserted vendor"
         #this should not happen at first time
      #if  eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.search([["name","=",vender.Name]])[0].blank? 
      #respartadd = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.new
      #respartadd.partner_id = oldres
      #respartadd.type = 'default'
      #respartadd.name = vender.Name
      #respartadd.street = vender.VendorAddress_Addr2
      #respartadd.street2 = vender.VendorAddress_Addr3
      #respartadd.city = vender.VendorAddress_City
      #respartadd.zip = vender.VendorAddress_PostalCode
      #respartadd.phone = vender.Phone
      #respartadd.mobile = vender.Mobile
      #respartadd.fax = vender.Fax
      #respartadd.email = vender.Email
      #respartadd.title = oldrest
      #respartadd.active =  vender.IsActive 
      #logger.info "from vendor save"
      #logger.info vender.Name
      #logger.info  respartadd.save
      #logger.info respartadd.id
      #end  
        
        respart.name = vender.Name
        respart.type = 'default'
        respart.customer = false
        respart.supplier = true  
        respart.employee = false
        respart.active =  vender.IsActive 
         if vender.Salutation.blank?
            respart.title = nil
          else
            oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",vender.Salutation]])[0]
           if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = vender.Salutation
             newrest.name = vender.Salutation
              newrest.domain = "contact"
              newrest.save
              oldrest = newrest.id     
           end
          respart.title = oldrest     
      end
      # respartadd = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.new
     # respartadd.partner_id = respart.id 
      respart.type = 'default'
      respart.name = vender.Name
      respart.street = vender.VendorAddress_Addr2
      respart.street2 = vender.VendorAddress_Addr3
      respart.city = vender.VendorAddress_City
      respart.zip = vender.VendorAddress_PostalCode
      respart.phone = vender.Phone
      respart.mobile = vender.Mobile
      respart.fax = vender.Fax
      respart.email = vender.Email
      respart.title = oldrest
      respart.active =  vender.IsActive 
      respart.save
       end 
  end
  
  def self.common_vendor_save(current_user,vender)
      logger.info "i am blank"
      respart = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
      respart.name = vender.Name
      respart.type = 'default'
      respart.customer = false
      respart.supplier = true  
      respart.employee = false
      de=DateTime.new(vender.TimeModified.split(" ")[0].split("/")[2].to_i,vender.TimeModified.split(" ")[0].split("/")[0].to_i,vender.TimeModified.split(" ")[0].split("/")[1].to_i,vender.TimeModified.split(" ")[1].split(":")[0].to_i,vender.TimeModified.split(" ")[1].split(":")[1].to_i,vender.TimeModified.split(" ")[1].split(":")[2].to_i)
      respart.quickbook_time = de
      respart.active =  vender.IsActive 
      respart.quick_list_number = vender.ListID
      respart.company_id = 1
      oldrest = nil
      respart.property_account_receivable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      respart.property_account_payable = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
      if vender.Salutation.blank?
        respart.title = nil
      else
        oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",vender.Salutation]])[0]
           if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = vender.Salutation
             newrest.name = vender.Salutation
             newrest.domain = "contact"
             newrest.save
             oldrest = newrest.id     
           end
          respart.title = oldrest     
      end
       
      respart.name = vender.Name
      respart.street = vender.VendorAddress_Addr2
      respart.street2 = vender.VendorAddress_Addr3
      respart.city = vender.VendorAddress_City
      respart.zip = vender.VendorAddress_PostalCode
      respart.phone = vender.Phone
      respart.mobile = vender.Mobile
      respart.fax = vender.Fax
      respart.email = vender.Email
      respart.title = oldrest
      logger.info "from vendor save"
     #else
        logger.info "already inserted vendor"
        respart.name = vender.Name
        respart.type = 'default'
        respart.customer = false
        respart.supplier = true  
        respart.employee = false
        respart.active =  vender.IsActive 
         if vender.Salutation.blank?
            respart.title = nil
          else
            oldrest = eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.search([["shortcut","=",vender.Salutation]])[0]
           if oldrest.blank?
             newrest =  eval(current_user.database.name.upcase.to_s)::ResPartnerTitle.new
             newrest.shortcut = vender.Salutation
             newrest.name = vender.Salutation
              newrest.domain = "contact"
              newrest.save
              oldrest = newrest.id     
           end
          respart.title = oldrest     
         end
      # respartadd = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.new
     # respartadd.partner_id = respart.id 
       
      respart.save
  end
  
end
