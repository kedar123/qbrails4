class Itemothercharge < ActiveRecord::Base
  # attr_accessible :title, :body
 #attr_accessible  :Name, :FullName, :IsActive
  self.table_name = "itemothercharge"
   has_one :Saleandpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   has_one :Saleorpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID

  
  
  def self.export_itemothercharge(itemothercharge,current_user)
          var = 1
           itemothercharge.each do |item|
              oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
               if oldac.blank?
                 self.common_other_charge(item,current_user,var)
               else
                 self.update_common_other_charge(item,current_user,var,oldac)
               end
              
           end #end of def
  end
  
  
   def self.update_common_other_charge(item,current_user,var,oldac)
       #begin

 
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Hours"]])[0]   
     
     
      oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
    else 
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
 
     
   
    propro.name = item.FullName
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "othercharge"]])[0]
       propro.categ_id = pctg
    end   
        
    
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
    logger.info "first come"
 if !item.Saleorpurchasedetail.blank?
   logger.info "second come"
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
  logger.info "third come"  
          propro.quick_product_account_id = acid 
    if !acid.blank?
      
    logger.info "four come"
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
    logger.info "five come"
   if acid.user_type.name == "Expense"
     logger.info "six come"
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
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.name = item.FullName
    protemp.type = 'service'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
    protemp.save
 
   
  
 
    end
      
  end
  
  
  
  def self.common_other_charge(item,current_user,var)
       #begin

 
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Hours"]])[0]   
     
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    propro.name = item.FullName
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "othercharge"]])[0]
       propro.categ_id = pctg
    end   
        
    
    propro.active = true#item.IsActive
    #propro.product_tmpl_id = protemp.id
    logger.info "first come"
 if !item.Saleorpurchasedetail.blank?
   logger.info "second come"
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
  logger.info "third come"  
          propro.quick_product_account_id = acid 
    if !acid.blank?
      
    logger.info "four come"
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
    logger.info "five come"
   if acid.user_type.name == "Expense"
     logger.info "six come"
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
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.name = item.FullName
    protemp.type = 'service'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
    protemp.save
 
   
  
 
      
  end
  
  
  
  
end
