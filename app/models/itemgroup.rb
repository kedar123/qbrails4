class Itemgroup < ActiveRecord::Base
   self.table_name =  "itemgroup"
  # attr_accessible :Name, :IsActive , :ItemDesc,:TimeModified
   
  
   has_one :Saleandpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   has_one :Saleorpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   
  
  
  def self.export_itemgroups(itemgroups,current_user)
 var = 1
   itemgroups.each do |item|
    # begin
    
 oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
  if oldac.blank?
        self.create_item_group(item,current_user,var)
  else
    logger.info "this is itemgroup should not happen"
    #this should not happen at first time
        self.update_item_group(item,current_user,var,oldac)
  end # end of do
 
  # rescue =>e
  #   logger.info "some error in itemgroup"
  #   logger.info e.message
  # end
 end
end

  
  def self.update_item_group(item,current_user,var,oldac)
     
      pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "All products"]])[0]
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
         
 
    oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
    else 
      logger.info "66666666666666666655555555555555555"
     propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
  
    propro.name = item.Name 
    propro.categ_id = pctg
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
      if !item.Saleorpurchasedetail.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
      
    elsif !item.Saleandpurchasedetail.blank?
      acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
    
    end
    
    
    propro.quick_product_account_id = acid
     if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
   if acid.user_type.name == "Expense"
      propro.property_account_expense = acid.id
    else  
      propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
    end
    if acid.user_type.name == "Income"
      propro.property_account_income = acid.id
    else 
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
    end
        else
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   
    end   
        
    propro.save
    
         
    protemp =  propro.product_tmpl_id
        
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.name = item.Name 
    protemp.uom_id = nuom
    protemp.uom_po_id = nuom
    
    protemp.save
    end
  end
  
  
  
  
  def self.create_item_group(item,current_user,var)
     
      pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "All products"]])[0]
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
         
 
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    propro.name = item.Name 
    propro.categ_id = pctg
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
      if !item.Saleorpurchasedetail.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
      
    elsif !item.Saleandpurchasedetail.blank?
      acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
    
    end
    
    
    propro.quick_product_account_id = acid
     if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
   if acid.user_type.name == "Expense"
      propro.property_account_expense = acid.id
    else  
      propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
    end
    if acid.user_type.name == "Income"
      propro.property_account_income = acid.id
    else 
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
    end
        else
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   
    end   
        
    propro.save
    
         
    protemp =  propro.product_tmpl_id
        
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.name = item.Name 
    protemp.uom_id = nuom
    protemp.uom_po_id = nuom
    
    protemp.save
  end
  
  
end
