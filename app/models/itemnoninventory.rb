class Itemnoninventory < ActiveRecord::Base
 # attr_accessible :Name, :FullName, :IsActive , :UnitOfMeasureSetRef_FullName , :Status
  self.table_name = "itemnoninventory"
   has_one :Saleandpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID
   has_one :Saleorpurchasedetail , :foreign_key =>  :IDKEY,:primary_key=>:ListID


  
  def self.export_itemnoninventory(itemnoninventory,current_user)
 var = 1
     itemnoninventory.each do |item|
       
      #begin
oldac = eval(current_user.database.name.upcase.to_s)::ProductTemplate.search([["quickbook_id","=",item.ListID]])[0] 
logger.info item.ListID
logger.info "is there any conflict"
logger.info  oldac
  if oldac.blank?
    p "itemnoninve............."
         self.createnoniteminventory(current_user,item,var)
  else
    logger.info "this should not happen at first time iteminventory"
    #this should not happen at first time
    logger.info "here sending an oldidddddddddd"
    logger.info oldac
    
          self.updatenoniteminventory(current_user,item,var,oldac)
    end 
    # rescue=>e
    #   logger.info "some error in iteminvent"
    #   logger.info e.message
    # end
      
end
end

  
  def self.updatenoniteminventory(current_user,item,var,oldac)
    logger.info "885555554444111111222222222"
        p var += 1
          
      nuom = eval(current_user.database.name.upcase.to_s)::ProductUom.search([['name', '=', "Unit(s)"]])[0]   
      
 
      oldptm = eval(current_user.database.name.upcase.to_s)::ProductTemplate.find(oldac)
      logger.info "finding all the productsssssssssssss"
      logger.info eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:all,:domain=>[['product_tmpl_id','=',oldptm.id]]).inspect
      logger.info "is it changed"
      logger.info oldptm.inspect
        datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
       if oldptm.quickbook_time == datetimec
         logger.info "its becauseeeeeee  the time is sameeeeee"
       else
 
     propro = eval(current_user.database.name.upcase.to_s)::ProductProduct.find(:first,:domain=>[['product_tmpl_id','=',oldptm.id]])
  logger.info "product product"
  logger.info propro.inspect
  logger.info oldptm.id
  logger.info "745212565"
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "noninventory"]])[0]
       propro.categ_id = pctg
    end    
        
        
        
        
  
    propro.active =true# item.IsActive
  #  propro.product_tmpl_id = protemp.id
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
 
  
        
        
    logger.info propro.save
    logger.info "product saveddddd"
    logger.info propro.inspect
       protemp =  propro.product_tmpl_id
       logger.info "just checking weather its uses existing object or new object"
       logger.info protemp.inspect
     protemp.name = item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    logger.info protemp.save
    logger.info "saving an product template object"
    logger.info protemp.inspect
    
  end
  end
  
  
  
  
  def self.createnoniteminventory(current_user,item,var)
       p var += 1
          logger.info "777415254585522325565215"
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
       pctg = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=', "noninventory"]])[0]
       propro.categ_id = pctg
    end    
        
        
        
        
  
    propro.active =true# item.IsActive
  #  propro.product_tmpl_id = protemp.id
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
    protemp.name = item.FullName
    protemp.type = 'product'
    protemp.cost_method = 'standard'
    protemp.procure_method = 'make_to_stock'
    protemp.quickbook_id = item.ListID
    datetimec = DateTime.new(item.TimeModified.split(" ")[0].split("/")[2].to_i,item.TimeModified.split(" ")[0].split("/")[0].to_i,item.TimeModified.split(" ")[0].split("/")[1].to_i,item.TimeModified.split(" ")[1].split(":")[0].to_i,item.TimeModified.split(" ")[1].split(":")[1].to_i,item.TimeModified.split(" ")[1].split(":")[2].to_i)
    protemp.quickbook_time = datetimec 
    
    protemp.mes_type = 'fixed'
    protemp.uom_po_id = nuom
    protemp.uom_id = nuom
    protemp.save
  end
  
  
  
end
