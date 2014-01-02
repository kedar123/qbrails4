class Itempayment < ActiveRecord::Base
  #attr_accessible  :Name, :IsActive,:ItemDesc,:DepositToAccountRef_FullName
  self.table_name = "itempayment"
  def self.export_itempayment(itempayment,current_user)
   var = 1
   itempayment.each do |item|
     #begin
  oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
  if oldac.blank?
      self.common_other_payment(item,current_user,var)
      #this method is for creation and other i want to be an updation
  else
    logger.info "this should not happen at first time"
        #this should not happen at first time
      self.common_other_payment_update(item,current_user,var,oldac)
  end # end of do 
 p " end of doooooooo"
  # rescue=>e
  #   logger.info "some error in itempayment"
  #   logger.info e.message
  # end
 end #end of def
end

  
   def self.common_other_payment_update(item,current_user,var,oldac)
           #p "item payment..................."
    #   p var += 1
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "payment"]])[0]
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Hours"]])[0]   
    
    
      oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
    else 
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
 
     
     
    propro.name = item.Name 
    propro.categ_id = pctg
    propro.active = true#item.IsActive
#    propro.product_tmpl_id = protemp.id
    
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.DepositToAccountRef_FullName.strip]])[0]
 #   propro.quick_product_account_id = acid
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
       protemp.quickbook_id =  item.ListID
       datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
        protemp.name = item.Name
    protemp.type = 'service'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
     
    protemp.save
  end
   end 
  
  
  
  def self.common_other_payment(item,current_user,var)
           #p "item payment..................."
    #   p var += 1
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "payment"]])[0]
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Hours"]])[0]   
   #    prtmp = eval(current_user.database.name.upcase.to_s)::ProductTemplate.new

#   p "last saving"
#    protemp = eval(current_user.database.name.upcase.to_s)::ProductTemplate.new 
#    protemp.name = item.Name
#    protemp.type = 'service'
#    protemp.cost_method = 'standard'
#    protemp.procure_method = 'make_to_stock'
#    protemp.mes_type = 'fixed'
#    protemp.description = item.ItemDesc
#    protemp.uom_po_id = nuom
#    protemp.uom_id = nuom
#    protemp.categ_id = pctg
#    protemp.save
    propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    propro.name = item.Name 
    propro.categ_id = pctg
    propro.active = true#item.IsActive
#    propro.product_tmpl_id = protemp.id
    
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.DepositToAccountRef_FullName.strip]])[0]
 #   propro.quick_product_account_id = acid
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
       protemp.quickbook_id =  item.ListID
       datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
        protemp.name = item.Name
    protemp.type = 'service'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.description = item.ItemDesc
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
     
    protemp.save
  end
  
  
end
