class Iteminventoryassembly < ActiveRecord::Base
  # attr_accessible :title, :body
  #attr_accessible  :COGSAccountRef_FullName,:Name, :FullName, :IsActive, :SalesDesc, :UnitOfMeasureSetRef_FullName, :SalesPrice ,:PurchaseCost,:PurchaseDesc
  self.table_name = "iteminventoryassembly"
  def self.export_iteminventoryaseemblies(iteminventory,current_user)
  var = 1
  count = 1
   iteminventory.each do |item|
     
    #begin
oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
  if oldac.blank?
       self.create_item_inventory_assembly(current_user,var,item)  
  else
    logger.info "this is iteminventoryassembly should not happen"
    count = count + 1
    logger.info "at last the count is 78"
    logger.info count
    self.update_item_inventory_assembly(current_user,var,item,oldac) 
    # this should not happen at first time
  end # end of do 
 logger.info " end of doooooooo"
 
        
 end #end of def
end

  
  def self.update_item_inventory_assembly(current_user,var,item,oldac) 
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0] 
      
        oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
    else 
      
     propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
  
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "inventoryassembly"]])[0]
       propro.categ_id = pctg
    end    
        
        
    propro.name = item.FullName
    
      acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.COGSAccountRef_FullName.strip]])[0]
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
    propro.active = true#item.IsActive
    propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]

 
    
    propro.save
    
        
    si = ""
    
        if current_user.user_payment_choice == "basic"
        else
                     logger.info "searching from stock inventory52"
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.search([["name","=","Qb_starting_Inventory"]])[0]
    
    if si.blank?
      
    logger.info "first time its blank65"
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.new
    si.state = 'done'
    si.name = 'Qb_starting_Inventory'
    si.save 
    logger.info "first time saved25"
    else
      logger.info "si is finding14"
      logger.info si
      si = eval(current_user.database.name.upcase.to_s)::StockInventory.find(si)
    end
    
    logger.info "creating a stock inventory lineeeee36"    
    sil = eval(current_user.database.name.upcase.to_s)::StockInventoryLine.new 
    logger.info "product id54"
    logger.info propro.id
    sil.product_id = propro.id
    logger.info "product id25"
    logger.info nuom
    logger.info "d556dsc46d5sc465ds65dscsdc47"
    
    sil.product_uom = nuom
    sil.location_id = eval(current_user.database.name.upcase.to_s)::StockLocation.search([["name","=","Stock"]])[0]
    sil.company_id = 1
    logger.info "product id548"
    logger.info si.id
    
    sil.inventory_id = si.id
    sil.product_qty = item.QuantityOnHand
    sil.save  
    logger.info "stock inventory line savedddd78"    
        sepq = eval(current_user.database.name.upcase.to_s)::StockChangeProductQty.new    
    sepq.location_id = 1
    sepq.new_quantity = item.QuantityOnHand
    sepq.product_id = propro.id
    sepq.save 
    #i am commenting the down if condition code as if there is a negative qty then there is no need to create an inventory.
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
#      sm.product_qty = item.QuantityOnHand.to_s.delete("-").to_i
#      sm.save
#      
#      spp = StockPartialPicking.new
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
#          
#          
# spo.call("draft_force_assign",[spo.id])
#  
#      spo.call("action_assign_wkf",[spo.id])
# 
#      spo.call("action_done",[spo.id])
#        
        
      begin
    sepq.call("change_product_qty",[sepq.id],{ "active_id" => sepq.product_id.id})
    rescue=>e
      logger.info "some error in creating a stock"
      logger.info e.message
      logger.info e.inspect
    end
     end
    
        
        
        end
    
      protemp =  propro.product_tmpl_id
    protemp.quickbook_id =  item.ListID
     protemp.name =  item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
   protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
        logger.info "the purchase costttt77"
    logger.info protemp.standard_price
    logger.info protemp.list_price
    protemp.save
  end
  end
  
  def self.create_item_inventory_assembly(current_user,var,item)
        nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
      propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.new
    
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "inventoryassembly"]])[0]
       propro.categ_id = pctg
    end    
        
        
    propro.name = item.FullName
    
      acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.COGSAccountRef_FullName.strip]])[0]
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
    propro.active = true#item.IsActive
    propro.property_stock_account_input = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=", item.AssetAccountRef_FullName.strip]])[0]

 
    
    propro.save
    
        
    si = ""
    
        if current_user.user_payment_choice == "basic"
        else
                     logger.info "searching from stock inventory52"
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.search([["name","=","Qb_starting_Inventory"]])[0]
    
    if si.blank?
      
    logger.info "first time its blank65"
    si = eval(current_user.database.name.upcase.to_s)::StockInventory.new
    si.state = 'done'
    si.name = 'Qb_starting_Inventory'
    si.save 
    logger.info "first time saved25"
    else
      logger.info "si is finding14"
      logger.info si
      si = eval(current_user.database.name.upcase.to_s)::StockInventory.find(si)
    end
    
    logger.info "creating a stock inventory lineeeee36"    
    sil = eval(current_user.database.name.upcase.to_s)::StockInventoryLine.new 
    logger.info "product id54"
    logger.info propro.id
    sil.product_id = propro.id
    logger.info "product id25"
    logger.info nuom
    logger.info "d556dsc46d5sc465ds65dscsdc47"
    
    sil.product_uom = nuom
    sil.location_id = eval(current_user.database.name.upcase.to_s)::StockLocation.search([["name","=","Stock"]])[0]
    sil.company_id = 1
    logger.info "product id548"
    logger.info si.id
    
    sil.inventory_id = si.id
    sil.product_qty = item.QuantityOnHand.to_s.delete("-").to_i
    sil.save  
    logger.info "stock inventory line savedddd78"    
        sepq = eval(current_user.database.name.upcase.to_s)::StockChangeProductQty.new    
    sepq.location_id = 12
    sepq.new_quantity = item.QuantityOnHand
    sepq.product_id = propro.id
    sepq.save 
    
      
   #i am commenting this because there is no need of negative qty in openerp   
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
#      sm.product_qty = item.QuantityOnHand
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
#      spo.call("draft_force_assign",[spo.id])
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
    
    protemp =  propro.product_tmpl_id
    protemp.quickbook_id =  item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    protemp.name =  item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    
    logger.info "the purchase costttt77"
    logger.info protemp.standard_price
    logger.info protemp.list_price
    protemp.save

  end
  
  
end
