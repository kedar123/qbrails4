class Itemsubtotal < ActiveRecord::Base
  # attr_accessible :title, :body
   self.table_name =  "itemsubtotal"
   #attr_accessible :Name, :IsActive , :ItemDesc
    has_one :Saleandpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   has_one :Saleorpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID

  def self.export_itemsubtotal(itemsubtotal,current_user)
 var = 1
 logger.info "item subtotal"
 logger.info itemsubtotal
 logger.info itemsubtotal.size
 
 
   itemsubtotal.each do |item|
     
   # begin
 oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
 logger.info oldac
 logger.info "oldddddd"
 
 
  if oldac.blank?
      self.common_sub_total(item,current_user,var)
  else
    logger.info "this should not happen at first time itemsubtotal"
    #this should not happen at first time
      self.common_update_sub_total(item,current_user,var,oldac)  
  end # end of do
 logger.info " in end of do ........."
 
  # rescue=>e
  #   logger.info "some error in itemsubtotal"
  #   logger.info e.message
  # end
 end
end

  
  
   def self.common_update_sub_total(item,current_user,var,oldac)
    logger.info "itemgroups....................."
   logger.info var += 1
        pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "subtotal"]])[0]
        nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
      oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
        datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
       if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else 
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
      
 
     propro.name = item.Name 
     propro.categ_id = pctg
   # propro.name = item.Name 
    propro.active = true#item.IsActive
   # propro.product_tmpl_id = protemp.id
 if !item.Saleorpurchasedetail.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
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
    elsif !item.Saleandpurchasedetail.blank?
      incacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.IncomeAccountRef_FullName.strip]])[0]
      expacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.ExpenseAccountRef_FullName.strip]])[0]
      #acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
      propro.property_account_expense = expacid
      propro.property_account_income = incacid 
      propro.quick_product_account_id = acid 
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
    protemp.name =  item.Name
    protemp.uom_id = nuom
    protemp.uom_po_id = nuom 
    
    logger.info " last last last........................"
    protemp.save
    logger.info "saving  pro temp saved .................. "
  end
   end 
  
  
  
  
  def self.common_sub_total(item,current_user,var)
    logger.info "itemgroups....................."
   logger.info var += 1
        pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "subtotal"]])[0]
        nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
    
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    
     propro.name = item.Name 
     
     propro.categ_id = pctg
   # propro.name = item.Name 
    propro.active = true#item.IsActive
   # propro.product_tmpl_id = protemp.id
 if !item.Saleorpurchasedetail.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
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
    elsif !item.Saleandpurchasedetail.blank?
      incacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.IncomeAccountRef_FullName.strip]])[0]
      expacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.ExpenseAccountRef_FullName.strip]])[0]
      #acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
      propro.property_account_expense = expacid
      propro.property_account_income = incacid 
      propro.quick_product_account_id = acid 
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
    protemp.name =  item.Name
    protemp.uom_id = nuom
    protemp.uom_po_id = nuom 
    
    logger.info " last last last........................"
    protemp.save
    logger.info "saving  pro temp saved .................. "
  end
  
end
