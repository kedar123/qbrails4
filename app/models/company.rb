class Company < ActiveRecord::Base
#attr_accessible  :CompanyName, :Phone,:CompanyWebSite , :Fax , :Email
  self.table_name = "company"
  def self.export_company(company,current_user)
  var = 1
   logger.info "in companyu..........................ssss"
    logger.info company.size
   company.each do |item|
    begin
   logger.info "in companyu.........................."
   logger.info var += 1
   #i am currently hiding all this things as in openerp7 there is no respartneraddress 
#   oldac = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.search([["name","=",item.CompanyName]])[0] 
   logger.info "ccccccccccccccc"
# if oldac.blank?
    logger.info "i am not blank"
#   respaddr = eval(current_user.database.name.upcase.to_s)::ResPartnerAddress.new
   
#   respaddr.phone = item.Phone
#   respaddr.fax = item.Fax
#   respaddr.email = item.Email
#   respaddr.name = item.CompanyName
   
 #  respart = eval(current_user.database.name.upcase.to_s)::ResPartner.new
      
    logger.info "5555555555555555888888888887777777777777"
    
    @a = eval(current_user.database.name.upcase.to_s)::ResCompany.find(1)
    
   logger.info "our company name is............" 
  logger.info item.CompanyName
 if @a.name == "Your Company"
    logger.info " your company name found......................changing..overidingg"
      @a.name = item.CompanyName
      @a.save      
   else
     @a.name = item.CompanyName
     @a.save
   end
 
#   p @a.id
  # respaddr.company_id = @a.id
  # respart.name = item.CompanyName
  # respaddr.type = "default"
  # respart.website = item.CompanyWebSite
  # respart.customer = false
  # respart.employee = false
  # respart.supplier = false
  # respart.active = true
  # respart.save

#   respaddr.partner_id = respart.id
 #  respaddr.save 
   logger.info "data saved successfullyy"
 #else
   logger.info "i am blankkkkkkkkkkkkkkkkkk need the updation code"
   # at starting point this condition will not come at all
 # end
   rescue => e
     logger.info "some problem in creation of company"
     logger.info e.message
   end
      
end
  end
end

