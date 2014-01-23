class Itemdiscount < ActiveRecord::Base
  self.table_name = "itemdiscount"
  #attr_accessible  :Name, :FullName, :IsActive, :ItemDesc,:DiscountRatePercent,:DiscountRate,:AccountRef_FullName,:ListID
  def self.export_itemdiscounts(itemdiscounts,current_user)
 var = 1
  itemdiscounts.each do |item|
      
   
  oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
  
        
      
  if oldac.blank?
        self.create_item_disc(item,current_user,var)
  else
    logger.info "this should not happen at first time item discount"
        self.create_item_disc_update(item,current_user,var,oldac)
    #this should not happen at first time
  end # end of do 
  
   # rescue =>e
   #   logger.info "some error in itemdiscount"
   #   logger.info e.message
   # end
      
  end
end

  
  def self.create_item_disc_update(item,current_user,var,oldac)
   nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]
   
    oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
        datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
       if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else 
  
   
   propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
      
   propro.name = item.FullName
    #this logic is need to be changed as per discussion with priya that if the parent ref is available then its category
    #will be that else the default category created that need to assign
    if !item.ParentRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.ParentRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       propro.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "itemdiscount"]])[0]
       propro.categ_id = pctg
    end
        
    
    propro.active = true#item.IsActive
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.AccountRef_FullName.strip]])[0]
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
    
 #    
 #   p protemp.id
    #propro.product_tmpl_id = protemp.id
    propro.save
    #ProductUom.search([['category_id', '=', "Hour"]])[0]  
#    
       protemp =  propro.product_tmpl_id
       protemp.uom_po_id = nuom
       protemp.uom_id = nuom
       #protemp.categ_id = pctg
      
       
    protemp.name = item.FullName
    protemp.type = 'service'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.list_price = item.DiscountRate if item.DiscountRate
    protemp.list_price = item.DiscountRatePercent if item.DiscountRatePercent
    protemp.standard_price = "0.00"
    protemp.company_id = 1
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
     
    protemp.quickbook_time = datetimec 
 #   
    protemp.save
     
   end
  end
  
  

  def self.create_item_disc(item,current_user,var)
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]
   propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
   propro.name = item.FullName
    #this logic is need to be changed as per discussion with priya that if the parent ref is available then its category
    #will be that else the default category created that need to assign
    if !item.ParentRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.ParentRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       propro.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "itemdiscount"]])[0]
       propro.categ_id = pctg
    end
        
    
    propro.active = true#item.IsActive
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.AccountRef_FullName.strip]])[0]
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
    
 #    
 #    
    #propro.product_tmpl_id = protemp.id
    propro.save
    #ProductUom.search([['category_id', '=', "Hour"]])[0]  
#    
#     
       protemp =  propro.product_tmpl_id
       protemp.uom_po_id = nuom
       protemp.uom_id = nuom
       #protemp.categ_id = pctg
      
       
    protemp.name = item.FullName
    protemp.type = 'service'
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
     
    protemp.quickbook_time = datetimec
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.list_price = item.DiscountRate if item.DiscountRate
    protemp.list_price = item.DiscountRatePercent if item.DiscountRatePercent
    protemp.standard_price = "0.00"
    protemp.company_id = 1
    protemp.quickbook_id = item.ListID
     
 #   
    protemp.save
     
  end
  
  
  
  
  
  
end
