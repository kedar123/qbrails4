class Itemfixedasset < ActiveRecord::Base
   #attr_accessible :Name, :IsActive,:PurchaseDesc,:PurchaseCost,:SerialNumber,:AssetAccountRef_FullName
   self.table_name = "itemfixedasset"
 def self.export_itemfixassets(itemfixassets,current_user)
  var = 1
  itemfixassets.each do |item|
    
  #begin
 oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
  if oldac.blank?


        self.create_item_fix_asset(item,current_user,var)
       
  else
logger.info "this should not happen at first time"    
#this should not be printed at first time
       self.update_item_fix_asset(item,current_user,var,oldac)
  end # end of do 
 # rescue =>e
 #   logger.info "some error in itemfixedasset"
 # end
 end
end

 
 def self.update_item_fix_asset(item,current_user,var,oldac)
        p "itemfixedaset........................"
   p var += 1
   p "itemfixasset called"
   p "in do inerrrrrrrrrrrrr"
    nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
  #   p " last last last........................"
 #   protemp.save
    p "saving  pro temp saved .................. "
    oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
    else 
     propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
  
     propro.name = item.Name 
     if !item.AssetAccountRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.AssetAccountRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.AssetAccountRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.AssetAccountRef_FullName]])[0]    
       propro.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "fixedasset"]])[0]
       propro.categ_id = pctg
    end   
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.AssetAccountRef_FullName.strip]])[0]
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
        propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]

    propro.default_code = item.SerialNumber
    propro.save
    protemp =  propro.product_tmpl_id
    
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.name = item.Name 
    protemp.description = item.Notes
    protemp.description_purchase = item.PurchaseDesc 
    protemp.standard_price = item.PurchaseCost
    protemp.sale_ok = false
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
    
    
       
 #   p " last last last........................"
    protemp.save
    end
 end
 
 

 
 def self.create_item_fix_asset(item,current_user,var)
      p "itemfixedaset........................"
   p var += 1
   p "itemfixasset called"
   p "in do inerrrrrrrrrrrrr"
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
  #   p " last last last........................"
 #   protemp.save
    p "saving  pro temp saved .................. "
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    propro.name = item.Name 
     if !item.AssetAccountRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.AssetAccountRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.AssetAccountRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.AssetAccountRef_FullName]])[0]    
       propro.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "fixedasset"]])[0]
       propro.categ_id = pctg
    end   
       
       
       
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.AssetAccountRef_FullName.strip]])[0]
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
        propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]

    propro.default_code = item.SerialNumber
    propro.save
    protemp =  propro.product_tmpl_id
    
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.name = item.Name 
    protemp.description = item.Notes
    protemp.description_purchase = item.PurchaseDesc 
    protemp.standard_price = item.PurchaseCost
    protemp.sale_ok = false
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
    
    
       
 #   p " last last last........................"
    protemp.save
 end
 
 
end
