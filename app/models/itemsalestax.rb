class Itemsalestax < ActiveRecord::Base
  #attr_accessible :Name, :IsActive , :ItemDesc, :TaxRate
  self.table_name = "itemsalestax"
  
  
  
  #here i need to first find all the active false elements and store there names so that i can check while creating a new one
  def self.export_item(itemsalestax,current_user)
    name_array = []
     logger.info "wwwwwwwwwwwwwwwwwww"
    eval(current_user.database.name.upcase.to_s)::AccountTax.search([['active', '=', false]]).each do |idtofetch|
      name_array << eval(current_user.database.name.upcase.to_s)::AccountTax.find(idtofetch).name
    end
    logger.info "wwwwwwwwwwwwwwwwwww"
    countsat = 0
    itemsalestax.each do |item|
     # begin
      logger.info "itemmmmmmmmmmmmmmmmmmm"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountTax.search([["name","=", item.Name]])
      oldact = eval(current_user.database.name.upcase.to_s)::AccountTax.search([["quickbook_id","=", item.ListID]])[0] 
      if oldact.blank?
        logger.info "it should always come here"
        logger.info countsat
        countsat = countsat + 1
          self.export_common_salestax(item,current_user,name_array)
       else
        logger.info "tax name is already therererereritst"
          self.export_common_salestax_update(item,current_user,name_array,oldact)
       #this should not happen at first time
      end
    #rescue =>e
    #  logger.info "itemsalestaxerror"
    #  logger.info e.message
    #end
  end
  end
  
  
  
  def self.export_common_salestax_update(item,current_user,name_array,oldact)
        logger.info "i am blankkkkkk"
      
      ac = eval(current_user.database.name.upcase.to_s)::AccountTax.find(oldact)
       datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
     
       if ac.quickbook_time == datetimec
           logger.info "its becauseeeeeee  the time is sameeeeee"
       else
          ac.name = item.Name
          ac.active = true#item.IsActive
          ac.description = item.ItemDesc
          ac.quickbook_id = item.ListID

          ac.quickbook_time = datetimec

          ac.amount = item.TaxRate
          ac.sequence=1
          ac.ref_base_sign=1
          ac.type_tax_use='sale'

          ac.price_include = false
          ac.type='percent'
          logger.info "before save error"
          ac.save
          logger.info "after save error"
       end  
    
      
  end
  
  
  
  
  
  
  def self.export_common_salestax(item,current_user,name_array)
        logger.info "i am blankkkkkk"
        logger.info name_array.inspect
        logger.info "ssssssssssss"
        logger.info item.Name
      if !name_array.include?(item.Name)
      ac = eval(current_user.database.name.upcase.to_s)::AccountTax.new
      ac.name = item.Name
      ac.active = true#item.IsActive
      ac.description = item.ItemDesc
      ac.quickbook_id = item.ListID
      datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
      ac.quickbook_time = datetimec
      ac.amount = item.TaxRate
      ac.sequence=1
      ac.ref_base_sign=1
      ac.type_tax_use='sale'
      ac.price_include = false
      ac.type='percent'
      logger.info "before save error"
      ac.save
      logger.info "after save error"
      else
        logger.info "its name is thereist"
      end
  end
  
  
  
end
