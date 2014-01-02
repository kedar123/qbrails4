class Itemservice < ActiveRecord::Base
  #attr_accessible :Name, :FullName, :IsActive , :UnitOfMeasureSetRef_FullName , :Status
  self.table_name = "itemservice"
   has_one :Saleandpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   has_one :Saleorpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID

  
  def self.export_itemservices(itemserv,current_user)
   var = 1
     itemserv.each do |item|
        
     #begin
        oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
        if oldac.blank?

             self.common_item_service(item,current_user,var)
        else
          logger.info "this should not happen at first time itemservice"
          #this should not happen at first time
          logger.info oldac
          self.common_item_service_update(item,current_user,var,oldac)
        end 
     #rescue => e
     #  logger.info "error in itemservice"
     #  logger.info e.message
     #end
       
     end
  end
  
  
  
  def self.common_item_service_update(item,current_user,var,oldac)
     logger.info "itemservice......................"
     
   logger.info var += 1
   
        oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
        datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
       if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
         logger.info "some updatessssssssssss44"
         
 #     prtmp = eval(current_user.database.name.upcase.to_s)::ProductTemplate.new
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=',"Hours"]])[0]
    
 #     logger.info nuom
  #    if nuom.blank?
        
      logger.info "i am blankkkk hererererer"
       
 #     puc = eval(current_user.database.name.upcase.to_s)::ProductUom.new
 #   puc.name = "Hours"
 #   puc.category_id = 1
 #       puc.factor = "8.000000000000"
 #       logger.info "wwwwwwwwww"
 #         puc.active =  true
 #         puc.uom_type = "smaller"
 #         puc.rounding = "0.01"
 #         logger.info puc
 #   puc.save
 #    nuom = puc.id 
 #    logger.info "created"
 #     end
      logger.info "this is uommmm"
   #   logger.info nuom
        
 #     prtmp.uom_id = nuom
 #     prtmp.uom_po_id = nuom 
 #     prtmp.categ_id = pctg
 #     prtmp.name = item.FullName
 #     prtmp.company_id =  1
 #     prtmp.type = "service"
 #     prtmp.supply_method = "buy"
 #     prtmp.purchase_method = "make_to_order"
 #     prtmp.categ_id = 1
 #     prtmp.standard_price = 0
 #     prtmp.cost_method = "standard"
 #     logger.info "Assigning Uom and Uom_Po id "
 #     prtmp.save
       
       
      newp = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
      
      
 #     newp.product_tmpl_id = prtmp.id
       
   
       if item.FullName.blank?
        newp.name = item.Name
      else
        newp.name = item.FullName
      end
      
      
      
    if !item.ParentRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.ParentRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       newp.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "itemservice"]])[0]
       newp.categ_id = pctg
    end  
        
       
      
        
    if !item.Saleorpurchasedetail.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
          newp.quick_product_account_id = acid 
    if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
 if acid.user_type.name == "Expense"
      newp.property_account_expense = acid.id
    else  
      newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
    end
    if acid.user_type.name == "Income"
      newp.property_account_income = acid.id
    else 
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
    end
        else
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   
    end
    elsif !item.Saleandpurchasedetail.blank?
      incacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.IncomeAccountRef_FullName.strip]])[0]
      expacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.ExpenseAccountRef_FullName.strip]])[0]
      #acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
      newp.property_account_expense = expacid
      newp.property_account_income = incacid 
      newp.quick_product_account_id = acid 
       else
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
        
         
    end
    
    

      newp.active = true#item.IsActive
      logger.info newp.save
       if nuom.blank?
           puc = eval(current_user.database.name.upcase.to_s)::ProductUom.new

         puc.name = "Hours"
    puc.category_id = 1
        puc.factor = "8.000000000000"
        logger.info "wwwwwwwwww"
          puc.active =  true
          puc.uom_type = "smaller"
          puc.rounding = "0.01"
          logger.info puc
    puc.save
      # end
     nuom = puc.id 
     logger.info "created"
      end
      logger.info "this is uommmm"
   #   logger.info nuom
       prtmp =  newp.product_tmpl_id
      
       prtmp.uom_id = nuom
       prtmp.uom_po_id = nuom 
       #prtmp.categ_id = pctg
       prtmp.name = item.FullName
       prtmp.quickbook_id = item.ListID
       datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
     
       prtmp.quickbook_time = datetimec
       
       prtmp.company_id =  1
       prtmp.type = "service"
       prtmp.supply_method = "buy"
       prtmp.purchase_method = "make_to_order"
       
       prtmp.standard_price = 0
       prtmp.cost_method = "standard"
 #     logger.info "Assigning Uom and Uom_Po id "
       prtmp.save
       end   
  end
  
  
   def self.common_item_service(item,current_user,var)
     logger.info "itemservice......................"
   logger.info var += 1
   
        
 #     prtmp = eval(current_user.database.name.upcase.to_s)::ProductTemplate.new
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=',"Hours"]])[0]
    
 #     logger.info nuom
  #    if nuom.blank?
        
      logger.info "i am blankkkk hererererer"
       
 #     puc = eval(current_user.database.name.upcase.to_s)::ProductUom.new
 #   puc.name = "Hours"
 #   puc.category_id = 1
 #       puc.factor = "8.000000000000"
 #       logger.info "wwwwwwwwww"
 #         puc.active =  true
 #         puc.uom_type = "smaller"
 #         puc.rounding = "0.01"
 #         logger.info puc
 #   puc.save
 #    nuom = puc.id 
 #    logger.info "created"
 #     end
      logger.info "this is uommmm"
   #   logger.info nuom
        
 #     prtmp.uom_id = nuom
 #     prtmp.uom_po_id = nuom 
 #     prtmp.categ_id = pctg
 #     prtmp.name = item.FullName
 #     prtmp.company_id =  1
 #     prtmp.type = "service"
 #     prtmp.supply_method = "buy"
 #     prtmp.purchase_method = "make_to_order"
 #     prtmp.categ_id = 1
 #     prtmp.standard_price = 0
 #     prtmp.cost_method = "standard"
 #     logger.info "Assigning Uom and Uom_Po id "
 #     prtmp.save
      
      newp = eval(current_user.database.name.upcase.to_s)::ProductProduct.new 
 #     newp.product_tmpl_id = prtmp.id
      if item.FullName.blank?
        newp.name = item.Name
      else
        newp.name = item.FullName
      end
      
   
    if !item.ParentRef_FullName.blank?
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       if checkparentreffn.blank?
           productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
           productcategory.name =    item.ParentRef_FullName
           productcategory.save
       end
       checkparentreffn = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=',item.ParentRef_FullName]])[0]    
       newp.categ_id = checkparentreffn 
    else
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "itemservice"]])[0]
       newp.categ_id = pctg
    end  
        
       
      
        
    if !item.Saleorpurchasedetail.blank? and !item.Saleorpurchasedetail.AccountRef_FullName.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleorpurchasedetail.AccountRef_FullName.strip]])[0]
          newp.quick_product_account_id = acid 
    if !acid.blank?
    acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(acid)
 if acid.user_type.name == "Expense"
      newp.property_account_expense = acid.id
    else  
      newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
    end
    if acid.user_type.name == "Income"
      newp.property_account_income = acid.id
    else 
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
      
    end
        else
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
   
    end
    elsif !item.Saleandpurchasedetail.blank? and !item.Saleandpurchasedetail.IncomeAccountRef_FullName.blank?
      incacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.IncomeAccountRef_FullName.strip]])[0]
      expacid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.ExpenseAccountRef_FullName.strip]])[0]
      #acid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=",item.Saleandpurchasedetail.AccountRef_FullName.strip]])[0]
      newp.property_account_expense = expacid
      newp.property_account_income = incacid 
      newp.quick_product_account_id = acid 
       else
      newp.property_account_income = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Receivable"]])[0]
     newp.property_account_expense = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","Accounts Payable"]])[0]
        
         
    end
    
    

      newp.active = true#item.IsActive
      logger.info newp.save
      logger.info "save errorrrrrrrrrrrrrr"
       if nuom.blank?
           puc = eval(current_user.database.name.upcase.to_s)::ProductUom.new

         puc.name = "Hours"
    puc.category_id = 1
        puc.factor = "8.000000000000"
        logger.info "wwwwwwwwww"
          puc.active =  true
          puc.uom_type = "smaller"
          puc.rounding = "0.01"
          logger.info puc
    puc.save
      # end
     nuom = puc.id 
     logger.info "created"
      end
      logger.info "this is uommmm"
   #   logger.info nuom
       prtmp =  newp.product_tmpl_id
      
       prtmp.uom_id = nuom
       prtmp.uom_po_id = nuom 
       #prtmp.categ_id = pctg
       
       prtmp.name = item.FullName
       if  item.FullName.blank?
         prtmp.name = item.Name
       else
         prtmp.name = item.FullName
       end
     
       prtmp.quickbook_id = item.ListID
       datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
     
       prtmp.quickbook_time = datetimec
       
       prtmp.company_id =  1
       prtmp.type = "service"
       prtmp.supply_method = "buy"
       prtmp.purchase_method = "make_to_order"
       
       prtmp.standard_price = 0
       prtmp.cost_method = "standard"
 #     logger.info "Assigning Uom and Uom_Po id "
      logger.info prtmp.save
      logger.info "product template error"
      
  end
  
  
  
  
  
end
