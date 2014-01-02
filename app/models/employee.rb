class Employee < ActiveRecord::Base
   self.table_name = "employee"
   #attr_accessible :Name, :IsActive,:Email,:EmployeeAddress_Addr1,:EmployeeAddress_Addr2,:SSN ,:EmployeeAddress_City,:Phone,:Mobile ,:EmployeeAddress_PostalCode 
   def self.import_employee(employee,current_user)
   var = 0
 p employee.count
 p employee.count
 p employee.count

employee.each do |item|
    begin
   if !item.Name.blank?
oldac =  eval(current_user.database.name.upcase.to_s)::ResourceResource.search([["quickbook_id","=",item.ListID.to_s]])[0]
if oldac.blank?
    p "in iffffffffffffffffffffffff"
       self.common_employee_save(current_user,item)
else
  p " name blankkkkkkkkkkkkkkkkkkkkkk"
   logger.info "this is need to be check at first timeeeeemployee"
     # this should not happen at first time
     self.common_employee_update(current_user,item,oldac)
end
  else
     logger.info "the name is blank employee"
     # this should not happen at first time
  end
  
rescue =>e
  logger.info "error in employee"
  logger.info e.message
end
       
       
   end
  end
  
  def self.common_employee_save(current_user,item)
   resource = eval(current_user.database.name.upcase.to_s)::ResourceResource.new
   resource.name = item.Name
   resource.active = item.IsActive
   resource.user_id = 1
   resource.company_id = 1
   resource.company_id = 1
   resource.quickbook_id = item.ListID.to_s
   datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
   resource.quickbook_time = datetimec
   resource.save
   
   old_res = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["quick_list_number","=","res"+item.ListID.to_s]])[0] 
   
   if old_res.blank?
   rpaddr = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
   rpaddr.street = item.EmployeeAddress_Addr1
   rpaddr.street2 = item.EmployeeAddress_Addr2
   rpaddr.city = item.EmployeeAddress_City 
   rpaddr.zip = item.EmployeeAddress_PostalCode
   rpaddr.type = "default"
   rpaddr.name = item.Name
   rpaddr.quick_list_number = "res"+item.ListID.to_s
   rpaddr.save
   else
   rpaddr = eval(current_user.database.name.upcase.to_s)::ResPartner.find(old_res) 
   rpaddr.street = item.EmployeeAddress_Addr1
   rpaddr.street2 = item.EmployeeAddress_Addr2
   rpaddr.city = item.EmployeeAddress_City 
   rpaddr.zip = item.EmployeeAddress_PostalCode
   rpaddr.type = "default"
   rpaddr.name = item.Name
   rpaddr.quick_list_number = "res"+item.ListID.to_s
#   p rpaddr.type
   p "b44 saveeeeeeeeee"
#   rpaddr.save
   rpaddr.save  
   end
    
   oldhr =  eval(current_user.database.name.upcase.to_s)::HrEmployee.search([["resource_id","=",resource.id.to_s]])[0]
   if  oldhr.blank?
     hremp = eval(current_user.database.name.upcase.to_s)::HrEmployee.new
   hremp.work_phone = item.Phone
   hremp.mobile_phone = item.Mobile
   hremp.ssnid = item.SSN
   hremp.work_email = item.Email
   hremp.gender = item.Gender.to_s.downcase if item.Gender
   hremp.birthday = item.BirthDate
   hremp.notes = item.Notes
   hremp.address_home_id = rpaddr.id 
   hremp.resource_id = resource.id
   hremp.save
   else
   hremp = eval(current_user.database.name.upcase.to_s)::HrEmployee.find(oldhr)
   hremp.work_phone = item.Phone
   hremp.mobile_phone = item.Mobile
   hremp.ssnid = item.SSN
   hremp.work_email = item.Email
   hremp.gender = item.Gender.to_s.downcase if item.Gender
   hremp.birthday = item.BirthDate
   hremp.notes = item.Notes
   hremp.address_home_id = rpaddr.id 
   hremp.resource_id = resource.id
   hremp.save
   end
   
   
    
   
  end 
  
  def self.common_employee_update(current_user,item,oldresource)
    logger.info "8888888888555555555555"
   resource = eval(current_user.database.name.upcase.to_s)::ResourceResource.find(oldresource)
   
      datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
        logger.info "555555555555555555555555555555"     
        logger.info datetimec
       if resource.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
    
    logger.info "its becauseeeeeee  the time is sameeee3333ee"
   resource.name = item.Name
   resource.active = item.IsActive
   resource.user_id = 1
   resource.company_id = 1
   resource.quickbook_id = item.ListID
   datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
   resource.quickbook_time = datetimec

   resource.save
    old_res = eval(current_user.database.name.upcase.to_s)::ResPartner.search([["quick_list_number","=","res"+item.ListID.to_s]])[0] 
   
   if old_res.blank?
   rpaddr = eval(current_user.database.name.upcase.to_s)::ResPartner.new 
   rpaddr.street = item.EmployeeAddress_Addr1
   rpaddr.street2 = item.EmployeeAddress_Addr2
   rpaddr.city = item.EmployeeAddress_City 
   rpaddr.zip = item.EmployeeAddress_PostalCode
   rpaddr.type = "default"
   rpaddr.name = item.Name
   rpaddr.quick_list_number = "res"+item.ListID.to_s
   rpaddr.save
   else
   rpaddr = eval(current_user.database.name.upcase.to_s)::ResPartner.find(old_res) 
   rpaddr.street = item.EmployeeAddress_Addr1
   rpaddr.street2 = item.EmployeeAddress_Addr2
   rpaddr.city = item.EmployeeAddress_City 
   rpaddr.zip = item.EmployeeAddress_PostalCode
   rpaddr.type = "default"
   rpaddr.name = item.Name
   rpaddr.quick_list_number = "res"+item.ListID.to_s
#   p rpaddr.type
   p "b44 saveeeeeeeeee"
#   rpaddr.save
   rpaddr.save  
   end
    
   oldhr =  eval(current_user.database.name.upcase.to_s)::HrEmployee.search([["resource_id","=",resource.id.to_s]])[0]
   if  oldhr.blank?
     hremp = eval(current_user.database.name.upcase.to_s)::HrEmployee.new
   hremp.work_phone = item.Phone
   hremp.mobile_phone = item.Mobile
   hremp.ssnid = item.SSN
   hremp.work_email = item.Email
   hremp.gender = item.Gender.to_s.downcase if item.Gender
   hremp.birthday = item.BirthDate
   hremp.notes = item.Notes
   hremp.address_home_id = rpaddr.id 
   hremp.resource_id = resource.id
   hremp.save
   else
   hremp = eval(current_user.database.name.upcase.to_s)::HrEmployee.find(oldhr)
   hremp.work_phone = item.Phone
   hremp.mobile_phone = item.Mobile
   hremp.ssnid = item.SSN
   hremp.work_email = item.Email
   hremp.gender = item.Gender.to_s.downcase if item.Gender
   hremp.birthday = item.BirthDate
   hremp.notes = item.Notes
   hremp.address_home_id = rpaddr.id 
   hremp.resource_id = resource.id
   hremp.save
   end
       end
  end
   
   
end
