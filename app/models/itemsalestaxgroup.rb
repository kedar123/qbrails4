class Itemsalestaxgroup < ActiveRecord::Base
  # attr_accessible :Name, :IsActive , :ItemDesc, :TaxRate
  self.table_name = "itemsalestaxgroup"
  
  
  
  #here i need to first find all the active false elements and store there names so that i can check while creating a new one
  def self.export_itemsalestgr(itemsalestaxgr,current_user)
     logger.info "wwwwwwwwwwwwwwwwwww85"
    itemsalestaxgr.each do |item|
      #begin
       name_array = []
     logger.info "wwwwwwwwwwwwwwwwwww"
    eval(current_user.database.name.upcase.to_s)::AccountTax.search([['active', '=', false]]).each do |idtofetch|
      name_array << eval(current_user.database.name.upcase.to_s)::AccountTax.find(idtofetch).name
    end 
       logger.info "itemmmmmmmmmmmmmmmmmmm265"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountTax.search([["name","=", item.Name]])
       oldact = eval(current_user.database.name.upcase.to_s)::AccountTax.search([["quickbook_id","=", item.ListID]])[0]
        
       if oldact.blank?
         self.common_sales_group(item,current_user,name_array)
       else
       logger.info "tax name is already thererererer happenistg"
         self.common_sales_group_update(item,current_user,name_array,oldact)
      #first time this should not happen 
       end
       
    #rescue =>e
    #  logger.info "someerror in itemsalestaxgroup"
    #  logger.info e.message
    #end
  end
  
  
  end
  
  
  
  def self.common_sales_group_update(item,current_user,name_array,oldact)
          logger.info "i am blankkkkkk"
       
          datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
          ac = eval(current_user.database.name.upcase.to_s)::AccountTax.find(oldact)
      
        if ac.quickbook_time == datetimec
           logger.info "its becauseeeeeee  the time is sameeeeee"
       else
      
      ac.name = item.Name
      ac.active =true# item.IsActive
      ac.description = item.ItemDesc
      ac.quickbook_id = item.ListID
        
      ac.quickbook_time = datetimec
      #ac.amount = item.TaxRate#commented because database 32 dosent have it
      ac.sequence=1
      ac.ref_base_sign=1
      ac.type_tax_use='sale'
      
      ac.price_include = false
      ac.type='percent'
      logger.info "before save error"
      ac.save
      logger.info "after save error"
      
        #first time also this should not happenistg
      end
      
  end
  
  
  
  def self.common_sales_group(item,current_user,name_array)
          logger.info "i am blankkkkkk"
      if !name_array.include?(item.Name)
      ac = eval(current_user.database.name.upcase.to_s)::AccountTax.new
      ac.name = item.Name
      ac.active =true# item.IsActive
      ac.description = item.ItemDesc
      ac.quickbook_id = item.ListID
      datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
      ac.quickbook_time = datetimec
      #ac.amount = item.TaxRate#commented because database 32 dosent have it
      ac.sequence=1
      ac.ref_base_sign=1
      ac.type_tax_use='sale'
      
      ac.price_include = false
      ac.type='percent'
      logger.info "before save error"
      ac.save
      logger.info "after save error"
      else
        logger.info "its name is there happenistg"
        #first time also this should not happenistg
      end
  end
  
  
end
