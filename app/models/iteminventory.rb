class Iteminventory < ActiveRecord::Base
  #attr_accessible  :COGSAccountRef_FullName,:Name, :FullName, :IsActive, :SalesDesc, :UnitOfMeasureSetRef_FullName, :SalesPrice ,:PurchaseCost,:PurchaseDesc
  self.table_name = "iteminventory"
  
  
  def self.export_iteminventories(iteminventory,current_user)
var = 1
count = 0
    iteminventory.each do |item|
   # begin 
    
oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
logger.info "searching product template name"
logger.info item.FullName
logger.info oldac.inspect


  if oldac.blank?
       self.create_inventory(current_user,item,var)
  else
    logger.info "this should not happen at first time"
    #at first time this should not happen
    self.update_inventory(current_user,item,var,oldac)
    count = count + 1
    logger.info count
    logger.info "this count should be 123"
  end # end of do 
 
 
        
 end #end of def
end # end of class

  
  
  
  def self.create_inventory(current_user,item,var)
      logger.info "this is blankkkkkkkkkk"
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0] 
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "inventory"]])[0]
       propro.categ_id = pctg
    end
   
    propro.active = true#item.IsActive
   # propro.product_tmpl_id = protemp.id
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.COGSAccountRef_FullName.strip]])[0]
    propro.quick_product_account_id = acid
    if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
    logger.info "this is user type"
    logger.info acid.user_type.name
    
   if acid.user_type.name == "Expense"
      propro.property_account_expense = acid.id
   else  
      logger.info "i should assign an acccount"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
      propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   end
   if acid.user_type.name == "Income"
      propro.property_account_income = acid.id
   else 
      logger.info "i should assign an acccount44"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
   end
        else
          logger.info "ultimetly here"
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
     #propro.quick_product_account_id =  
    end
    #logger.info "beforesave sale price"
    #logger.info protemp.standard_price
    #logger.info protemp.list_price
    #logger.info propro.property_account_expense
    logger.info "this need to be product saveeee"
    logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])
    propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]
        
        
    logger.info propro.inspect
    propro.save
      logger.info "this need to be product saveeee123"
    logger.info propro.inspect
     logger.info "beforesave sale price254"
    #logger.info protemp.standard_price
    #logger.info protemp.list_price
    si = ""  
    logger.info "searching from stock inventory"
     logger.info propro.property_account_expense
    if current_user.user_payment_choice == "basic"
    else
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.search([["name","=","Qb_starting_Inventory"]])[0]
    
    if si.blank?
      #when creating an inventory i need to check if qty is negative then need to escape it else create all this things.
    logger.info "first time its blank"
    
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.new
    si.state = 'done'
    si.name = 'Qb_starting_Inventory'
    si.save 
    logger.info "first time saved"
    logger.info propro.property_account_expense
    
    else
      logger.info "si is finding"
      logger.info si
      si = eval(current_user.database.name.upcase.to_s)::StockInventory.find(si)
    end
    
    logger.info "creating a stock inventory lineeeee"    
    sil = eval(current_user.database.name.upcase.to_s)::StockInventoryLine.new 
    logger.info "product id"
    logger.info propro.id
    sil.product_id = propro.id
    logger.info "product id"
    logger.info nuom
    logger.info "d556dsc46d5sc465ds65dscsdc"
    
    sil.product_uom = nuom
    
    sil.location_id = eval(current_user.database.name.upcase.to_s)::StockLocation.search([["name","=","Stock"]])[0]
    sil.company_id = 1
    logger.info "product id"
    logger.info si.id
    
    sil.inventory_id = si.id
    sil.product_qty = item.QuantityOnHand.to_s.delete("-").to_i
    sil.save  
    logger.info "stock inventory line savedddd"    
    logger.info propro.property_account_expense
    sepq = eval(current_user.database.name.upcase.to_s)::StockChangeProductQty.new    
    sepq.location_id = 12
    sepq.new_quantity = item.QuantityOnHand
    sepq.product_id = propro.id
    sepq.save 
    #here i am calling one function for the purpose of qty update but there is error where if
    #negative qty is written then error is thrown which i will need to discuss with rahulto
    #now i am commenting this as if there is a negative qty then there is no need to create a stockpickingout.
    if item.QuantityOnHand.to_i < 0
#      spo=eval(current_user.database.name.upcase.to_s)::StockPickingOut.new
#      spo.save
#     sm=eval(current_user.database.name.upcase.to_s)::StockMove.new
#      sm.product_id = propro.id
#      sm.location_id = 5
#      sm.location_dest_id=12
#      sm.picking_id = spo.id
#      sm.type = "out"
#      sm.product_uom = 1
#      sm.name = propro.name
#      sm.product_qty = item.QuantityOnHand
#      sm.save
#      
#      spp = eval(current_user.database.name.upcase.to_s)::StockPartialPicking.new
#      spp.date = Time.now
#      spp.picking_id = spo.id
#      spp.save
#      
#      sppkln = eval(current_user.database.name.upcase.to_s)::StockPartialPickingLine.new
#      sppkln.location_dest_id = 9
#      sppkln.location_id = 12
#      sppkln.move_id = sm.id
#      sppkln.product_id = propro.id
#      sppkln.product_uom = 1
#      sppkln.wiward_id = spp.id
#      sppkln.quantity = item.QuantityOnHand.to_s.delete("-")
#      sppkln.save  
#      
#      
#      spo.call("draft_force_assign",[spo.id])
#  
#      spo.call("action_assign_wkf",[spo.id])
# 
#      spo.call("action_done",[spo.id])
#      
 
      
    else
    begin
    sepq.call("change_product_qty",[sepq.id],{ "active_id" => sepq.product_id.id})
    rescue=>e
      logger.info "some error in creating a stock"
      logger.info e.message
      logger.info e.inspect
    end
    end
      
    end
             
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "PCE"]])[0] 
    protemp =  propro.product_tmpl_id
    
    protemp.name =  item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.description_sale = item.SalesDesc
    protemp.list_price = item.SalesPrice.to_s
    protemp.standard_price = item.PurchaseCost.to_s
    protemp.description_purchase = item.PurchaseDesc
    logger.info "beforesave sale price55"
    logger.info protemp.standard_price
    logger.info protemp.list_price
    protemp.save
  end
  
   def self.update_inventory(current_user,item,var,oldac)
      oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
        datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
       if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
     
     
      logger.info "this is blankkkkkkkkkk555555555555555555"
       nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0] 
   
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "inventory"]])[0]
       propro.categ_id = pctg
    end
   
    propro.active = true#item.IsActive
   # propro.product_tmpl_id = protemp.id
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.COGSAccountRef_FullName.strip]])[0]
    propro.quick_product_account_id = acid
    if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
    logger.info "this is user type"
    logger.info acid.user_type.name
    
   if acid.user_type.name == "Expense"
      propro.property_account_expense = acid.id
   else  
      logger.info "i should assign an acccount"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
      propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   end
   if acid.user_type.name == "Income"
      propro.property_account_income = acid.id
   else 
      logger.info "i should assign an acccount44"
      logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
   end
        else
          logger.info "ultimetly here"
      propro.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     propro.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
     #propro.quick_product_account_id =  
    end
    #logger.info "beforesave sale price"
    #logger.info protemp.standard_price
    #logger.info protemp.list_price
    #logger.info propro.property_account_expense
    logger.info "this need to be product saveeee"
    logger.info eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])
    propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]
        
        
    logger.info propro.inspect
    propro.save
      logger.info "this need to be product saveeee123"
    logger.info propro.inspect
     logger.info "beforesave sale price254"
    #logger.info protemp.standard_price
    #logger.info protemp.list_price
    si = ""  
    logger.info "searching from stock inventory"
     logger.info propro.property_account_expense
    if current_user.user_payment_choice == "basic"
    else
          si = eval(current_user.database.name.upcase.to_s)::StockInventory.search([["name","=","Qb_starting_Inventory"]])[0]
    
    if si.blank?
      
    logger.info "first time its blank"
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.new
    si.state = 'done'
    si.name = 'Qb_starting_Inventory'
    si.save 
    logger.info "first time saved"
    logger.info propro.property_account_expense
    
    else
      logger.info "si is finding"
      logger.info si
      si = eval(current_user.database.name.upcase.to_s)::StockInventory.find(si)
    end
    
    logger.info "creating a stock inventory lineeeee"    
    sil = eval(current_user.database.name.upcase.to_s)::StockInventoryLine.new 
    logger.info "product id"
    logger.info propro.id
    sil.product_id = propro.id
    logger.info "product id"
    logger.info nuom
    logger.info "d556dsc46d5sc465ds65dscsdc"
    
    sil.product_uom = nuom
    
    sil.location_id = eval(current_user.database.name.upcase.to_s)::StockLocation.search([["name","=","Stock"]])[0]
    sil.company_id = 1
    logger.info "product id"
    logger.info si.id
    
    sil.inventory_id = si.id
    sil.product_qty = item.QuantityOnHand
    sil.save  
    logger.info "stock inventory line savedddd"    
     logger.info propro.property_account_expense
   
        
        
        
    sepq = eval(current_user.database.name.upcase.to_s)::StockChangeProductQty.new    
    sepq.location_id = 1
    sepq.new_quantity = item.QuantityOnHand
    sepq.product_id = propro.id
    sepq.save 
           
      if item.QuantityOnHand.to_i < 0
#      spo=eval(current_user.database.name.upcase.to_s)::StockPickingOut.new
#      spo.save
#      sm=eval(current_user.database.name.upcase.to_s)::StockMove.new
#      sm.product_id = propro.id
#      sm.location_id = 5
#      sm.location_dest_id=12
#      sm.picking_id = spo.id
#      sm.type = "out"
#        sm.product_uom = 1
#      sm.name = propro.name
#      sm.product_qty = item.QuantityOnHand.to_s.delete("-")
#      sm.save
#      
#      spp = eval(current_user.database.name.upcase.to_s)::StockPartialPicking.new
#      spp.date = Time.now
#      spp.picking_id = spo.id
#      spp.save
#      
#       sppkln = eval(current_user.database.name.upcase.to_s)::StockPartialPickingLine.new
#      sppkln.location_dest_id = 9
#      sppkln.location_id = 12
#      sppkln.move_id = sm.id
#      sppkln.product_id = propro.id
#      sppkln.product_uom = 1
#      sppkln.wiward_id = spp.id
#      sppkln.quantity = item.QuantityOnHand.to_s.delete("-")
#      sppkln.save     
#           
# spo.call("draft_force_assign",[spo.id])
#  
#      spo.call("action_assign_wkf",[spo.id])
# 
#      spo.call("action_done",[spo.id])
    else    
         
      begin
    sepq.call("change_product_qty",[sepq.id],{ "active_id" => sepq.product_id.id})
    rescue=>e
      logger.info "some error in creating a stock"
      logger.info e.message
      logger.info e.inspect
    end
      end  
    end
             
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "PCE"]])[0] 
    protemp =  propro.product_tmpl_id
    
    protemp.name =  item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.description_sale = item.SalesDesc
    protemp.list_price = item.SalesPrice.to_s
    protemp.standard_price = item.PurchaseCost.to_s
    protemp.description_purchase = item.PurchaseDesc
    logger.info "beforesave sale price55"
    logger.info protemp.standard_price
    logger.info protemp.list_price
     protemp.save
    end
  end
end
