class Account < ActiveRecord::Base
  #attr_accessible :ListID,:Name, :IsActive , :ParentRef_FullName, :Sublevel, :AccountType,:AccountNumber, :Description,:ListID,:ParentRef_ListID,:ParentRef_FullName
   self.table_name = "account"
   self.primary_key = "ListID"
   
  def self.export_account(account,current_user)
    self.create_journal(current_user)
    #here i am creating an product category as per told by priyanka and taken the code from kalpana
    #also i put the code here because account should be called first as in each product its account is get assigned
    
     itemdiscount = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','itemdiscount']])[0]
     if itemdiscount.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =  "itemdiscount"
             productcategory.save
     end
     
     fixedasset = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','fixedasset']])[0]
     if fixedasset.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =  "fixedasset"
             productcategory.save
     end
     inventory = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','inventory']])[0]
     if inventory.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "inventory"
             productcategory.save
     end
     inventoryassembly = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','inventoryassembly']])[0]
     if inventoryassembly.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "inventoryassembly"
             productcategory.save
     end
     noninventory = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','noninventory']])[0]
     if noninventory.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "noninventory"
             productcategory.save
     end    
     othercharge = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','othercharge']])[0]
     if othercharge.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "othercharge"
             productcategory.save
     end    
     payment = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','payment']])[0]
     if payment.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "payment"
             productcategory.save
     end
     receipt = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','receipt']])[0]
     if receipt.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "receipt"
             productcategory.save
     end
    
     
     itemservice = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','itemservice']])[0]
     if itemservice.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "itemservice"
             productcategory.save
     end    
    
     subtotal = eval(current_user.database.name.upcase.to_s)::ProductCategory.search([['name', '=','subtotal']])[0]
     if subtotal.blank?
             productcategory = eval(current_user.database.name.upcase.to_s)::ProductCategory.new
             productcategory.name =   "subtotal"
             productcategory.save
     end    
    
    
    
    logger.info "s5s5s5s5s5s5s5s5s5s5s5s5s55s5s5s5s5ss55"
       @rescompany = eval(current_user.database.name.upcase.to_s)::ResCompany.find(1)
    logger.info 1   
          @user_type = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=',"Root/View"]])[0] 
   logger.info 2
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',@rescompany.name]])[0]
    if @oldco.blank?
       @a=eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>@rescompany.name,:code =>@rescompany.name,:type =>"view",:user_type=>@user_type,:parent_id =>"")  
    else
      @a = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@oldco)
    end
    
     logger.info 3
    @parent_id = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',@a.name]])[0] 
    logger.info 4
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Balance Sheet']])[0]
   if @oldco.blank?
            @a1=eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Balance Sheet",:code =>"Ac_1",:type =>"view",:user_type =>@user_type,:parent_id =>@parent_id )  
           logger.info 5
             @a1 =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Balance Sheet']])[0]
             @a1 = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@a1)
    else
           @a1=eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@oldco)
    end     
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Profit&Loss Account']])[0]
    if @oldco.blank?
            @a2=eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Profit&Loss Account",:code =>"Ac_2",:type =>"view",:user_type =>@user_type,:parent_id =>@parent_id )
            @a2=eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Profit&Loss Account']])[0]
            @a2=eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@a2) 
    else
      @a2=eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@oldco)
    end
    
        
         logger.info 6
           @user_type1 = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=',"Asset"]])[0]   # For Asset
           logger.info 7
           @parent_id1 = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',@a1.name]])[0] 
           logger.info 8
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Asset']])[0]
    logger.info 9
    if @oldco.blank?
            @a3=eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Asset",:code =>"Ac_1_1",:type =>"view",:user_type =>@user_type1,:parent_id =>@parent_id1)
            @a3 =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Asset']])[0]
            @a3 =   eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@a3) 
     logger.info 10       
            
    else
      @a3=eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@oldco)
      logger.info 11
    end   
    
        eq = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Equity']])[0]

    eqa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Equity']])[0]
 
       if eqa.blank?
           eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Equity",:code =>"Equity",:type =>"view",:user_type =>eq,:parent_id =>@parent_id1)
       end
         
           @user_type2 = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=',"Liability"]])[0]  # For Liability
       logger.info 12    
    
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Liability']])[0]
    logger.info 13
    if @oldco.blank?
        logger.info 14   
           @a4=eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Liability",:code =>"Ac_1_2",:type =>"view",:user_type =>@user_type2,:parent_id =>@parent_id1 )
           @a4 =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Liability']])[0]
           @a4 =   eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@a4) 
           logger.info 15
      
    else
      @a4=eval(current_user.database.name.upcase.to_s)::AccountAccount.find(@oldco)
      logger.info 16
    end
    
    
    
        @user_type3 = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=',"Expense"]])[0]  # For Expense
        logger.info 17
           @parent_id2 = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',@a2.name]])[0] 
   logger.info 18
    @oldco =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Expense']])[0]
    if @oldco.blank?
             eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Expense",:code =>"Ac_2_1",:type =>"view",:user_type =>@user_type3,:parent_id =>@parent_id2 )
 logger.info 19            
    else
    end  
    
    
    
    
    # For ctrating account_type Equity and Revenue.check duplication
    exp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Bank']])[0]
    logger.info 20            
    if exp.blank?
      eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Bank",:code =>"Bank",:report_type =>"asset",:close_method =>"balance")
    else
    end
    logger.info 21            
    chk = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Check']])[0]
    if chk.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Check",:code =>"Check",:report_type =>"asset",:close_method =>"balance")
    else
    end
logger.info 22            
    acrv = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','AccountsReceivable']])[0]
    if acrv.blank?
               eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"AccountsReceivable",:code =>"AccountsReceivable",:report_type =>"asset",:close_method =>"unreconciled")
    else
    end
    
logger.info 23            
  
    #kedar will do this later
  logger.info 24              

        othca = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherCurrentAsset']])[0]
        
    if othca.blank?
       eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"OtherCurrentAsset",:code =>"OtherCurrentAsset",:report_type =>"asset",:close_method =>"balance")
    else
    end
    
    

       fixedd = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Fixed']])[0]
        
       if fixedd.blank?
              eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Fixed",:code =>"Fixed",:report_type =>"asset",:close_method =>"balance")
       else
       end
    
   fixedda = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','FixedAsset']])[0]
    
    if fixedda.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"FixedAsset",:code =>"FixedAsset",:report_type =>"asset",:close_method =>"balance")

    else
    end
    

    
    
    logger.info 25            
   oas = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherAsset']])[0]

     if oas.blank?
         eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"OtherAsset",:code =>"OtherAsset",:report_type =>"asset",:close_method =>"balance")
     else
     end

   ap = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','AccountsPayable']])[0]
 
    if ap.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"AccountsPayable",:code =>"AccountsPayable",:report_type =>"liability",:close_method =>"unreconciled")

    else
    end
    
    cl = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Current Liability']])[0]
    if cl.blank?
                 eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Current Liability",:code =>"Current Liability",:report_type =>"liability",:close_method =>"balance")

    else
    end

    ocl = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherCurrentLiability']])[0]

    if ocl.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"OtherCurrentLiability",:code =>"OtherCurrentLiability",:report_type =>"liability",:close_method =>"balance")
    else
    end
    
    ccr = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','CreditCard']])[0]
    
 
    
    
    
    if ccr.blank?
    eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"CreditCard",:code =>"CreditCard",:report_type =>"liability",:close_method =>"balance")      
    else
    end
    
    
       
logger.info 26

    llb = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','LongTermLiability']])[0]
    
    if llb.blank?
      eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"LongTermLiability",:code =>"LongTermLiability",:report_type =>"liability",:close_method =>"balance")
    else
    end
    
eqt = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Equity']])[0]
       
    if eqt.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Equity",:code =>"Equity",:report_type =>"liability",:close_method =>"balance")
    else
    end
 
eqt = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Income']])[0]
       
    if eqt.blank?
           eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Income",:code =>"Income",:report_type =>"income",:close_method =>"balance")
    else
    end
 
oinc = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherIncome']])[0]
       
    if oinc.blank?
                 eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"OtherIncome",:code =>"OtherIncome",:report_type =>"income",:close_method =>"balance")

    else
    end
   logger.info 27            
exp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Expense']])[0]
       
    if exp.blank?
       eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"Expense",:code =>"Expense",:report_type =>"expense",:close_method =>"balance")
    else
    end
    
oexp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherExpense']])[0]
       
    if oexp.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"OtherExpense",:code =>"OtherExpense",:report_type =>"expense",:close_method =>"balance")

    else
    end
    
cogs = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','CostOfGoodsSold']])[0]
    if cogs.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccountType.create(:name =>"CostOfGoodsSold",:code =>"CostOfGoodsSold",:report_type =>"expense",:close_method =>"balance")

    else
    end
    
        

            
    logger.info "28.44" 
           check = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Check']])[0]
logger.info "28.45"
          # eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Check",:code =>"Check",:type =>"view",:user_type =>check,:parent_id =>@a3.id)
logger.info "28.46"


    
    
               otherasset = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherCurrentAsset']])[0]
logger.info 29

    abnk =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','OtherCurrentAsset']])[0]
         if abnk.blank?
         eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"OtherCurrentAsset",:code =>"OtherCurrentAsset",:type =>"view",:user_type =>otherasset,:parent_id =>@a3.id)
          end
            
       fixed = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Fixed']])[0]

   # eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Fixed",:code =>"fixed",:type =>"view",:user_type =>fixed,:parent_id =>@a3.id)
       fixeda = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','FixedAsset']])[0]

   acfa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','FixedAsset']])[0]
         if acfa.blank?
               eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"FixedAsset",:code =>"FixedAsset",:type =>"view",:user_type =>fixeda,:parent_id =>@a3.id)
         end
   @acca =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','CurrentAsset']])[0]
         if @acca.blank?
              @acca= eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"CurrentAsset",:code =>"CurrentAsset",:type =>"view",:user_type =>fixeda,:parent_id =>@a3.id)
         end
         
               bankid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Bank']])[0]
           
logger.info 28  
            abnk =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Bank']])[0]
            if abnk.blank?
             eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Bank",:code =>"Bank",:type =>"view",:user_type =>bankid,:parent_id =>@acca.id)
            end
    
    
    
    
    
    
        accountsReceivable = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','AccountsReceivable']])[0]
logger.info "28.478"

    acrv = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","=","AccountsReceivable"]])[0]
    
    if acrv.blank?
        logger.info "28.ssss47"
        
      @acrectype = "other"    
      checklistidr = Account.where("ParentRef_FullName = 'AccountsReceivable'")
      #if ac has a child then its type is view
      if checklistidr[0].blank?
        @acrectype = "other"
      else
        @acrectype = "view"
      end
      
      
        eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"AccountsReceivable",:code =>"AccountsReceivable",:type =>"view",:user_type =>accountsReceivable,:parent_id =>@acca.id)
       logger.info "28.47"
    end
    
    
    
    
    
    
    
    
    
         
    

       fixedot = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherAsset']])[0]

       aoa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','OtherAsset']])[0]
         if aoa.blank?
              eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"OtherAsset",:code =>"OtherAsset",:type =>"view",:user_type =>@user_type3,:parent_id =>@a3.id)
         end
    

    

       
    
    
    
    
    crl = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Current Liability']])[0]

    #eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Current Liability",:code =>"Current Liability",:type =>"view",:user_type =>crl,:parent_id =>@parent_id2)
       @ocrl = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherCurrentLiability']])[0]

    
          @ocla =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','OtherCurrentLiability']])[0]
 
       if @ocla.blank?
          @ocla= eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"OtherCurrentLiability",:code =>"OtherCurrentLiability",:type =>"view",:user_type =>@ocrl,:parent_id =>@a4.id)
          @ocla = @ocla.id
        end
    
          cc = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','CreditCard']])[0]

          occa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','CreditCard']])[0]
 
    
          @acrectypecr = "other"    
      checklisticr = Account.where("ParentRef_FullName = 'CreditCard'")
      #if ac has a child then its type is view
      if checklisticr[0].blank?
         checklistidoetype = Account.where("AccountType = 'CreditCard'")
        
         if checklistidoetype[0].blank?
           @acrectypecr = "other"
         else
          @acrectypecr = "view"
         end
      
      
       
      else
        @acrectypecr = "view"
      end
    
    
       if occa.blank?
    
        eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"CreditCard",:code =>"CreditCard",:type =>@acrectypecr,:user_type =>cc,:parent_id =>@ocla)
       end
    
    
    
    
      @clai =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','CurrentLiability']])[0]
 
       if @clai.blank?
           @clai= eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"CurrentLiability",:code =>"CurrentLiability",:type =>"view",:user_type =>@ocrl,:parent_id =>@a4.id)
       end
       
    
      acp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','AccountsPayable']])[0]

      acpa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','AccountsPayable']])[0]
 
      @acpyctype = "other"    
      checklistidap = Account.where("ParentRef_FullName = 'AccountsPayable'")
      #if ac has a child then its type is view
      if checklistidap[0].blank?
        @acpyctype = "other"
      else
        @acpyctype = "view"
      end
    
    
      if acpa.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"AccountsPayable",:code =>"AccountsPayable",:type =>"view",:user_type =>acp,:parent_id =>@clai.id)
      end
    
    
    
    
    logger.info 30            
     
    
    ll = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','LongTermLiability']])[0]

    lla =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','LongTermLiability']])[0]
 
       if lla.blank?
    
    
    eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"LongTermLiability",:code =>"LongTermLiability",:type =>"view",:user_type =>ll,:parent_id =>@a4.id)
       end
    
    
    

    
    inc = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Income']])[0]

    eqai =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Income']])[0]
 
    
    
          @acpyctypei = "other"    
      checklistidpi = Account.where("ParentRef_FullName = 'Income'")
      #if ac has a child then its type is view
      if checklistidpi[0].blank?
          checklistidoetype = Account.where("AccountType = 'Income'")
        
         if checklistidoetype[0].blank?
           @acpyctypei = "other"
         else
          @acpyctypei = "view"
         end
      
         
      else
        @acpyctypei = "view"
      end
    
       if eqai.blank?
         eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Income",:code =>"Income",:type =>@acpyctypei,:user_type =>inc,:parent_id =>@parent_id2)
       end
    
          
    
    
    oinc = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherIncome']])[0]
logger.info 31                  
    incoaid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=', "Income"]])[0]
      
  oic =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','OtherIncome']])[0]
 
       if oic.blank?
          eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"OtherIncome",:code =>"OtherIncome",:type =>"view",:user_type =>oinc,:parent_id =>incoaid)
       end
    
    exp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','Expense']])[0]

   # eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"Expense",:code =>"Expense",:type =>"view",:user_type =>exp,:parent_id =>@parent_id2)
    excoaid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=', "Expense"]])[0]

    oexp = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','OtherExpense']])[0]

  oice =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','OtherExpense']])[0]
 
    
    
           @acpyctypeoe = "other"    
      checklistidoe = Account.where("ParentRef_FullName = 'OtherExpense'")
      #if ac has a child then its type is view
      if checklistidoe[0].blank?
             #here i need to fire one more query as if the type is also belongs to this account then also its type is view. because when 
             #creating an account i am checking if its parent reference is null then assign the parent as per its account type.
        checklistidoetype = Account.where("AccountType = 'OtherExpense'")
        
         if checklistidoetype[0].blank?
           @acpyctypeoe = "other"
         else
           @acpyctypeoe = "view"
         end
      else
        @acpyctypeoe = "view"
      end
    
    
    
       if oice.blank?

    eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"OtherExpense",:code =>"OtherExpense",:type =>@acpyctypeoe,:user_type =>oexp,:parent_id =>excoaid)
       end
    
    
    cogs = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=','CostOfGoodsSold']])[0]

  cogsa =  eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','CostOfGoodsSold']])[0]
 
               @acpyctypeco = "other"    
      checklistidcog = Account.where("ParentRef_FullName = 'CostOfGoodsSold'")
      #if ac has a child then its type is view
      if checklistidcog[0].blank?
        
       checklistidoetype = Account.where("AccountType = 'CostOfGoodsSold'")
        
         if checklistidoetype[0].blank?
           @acpyctypeco = "other"
         else
           @acpyctypeco = "view"
         end
                
      else
        @acpyctypeco = "view"
      end
    
    
    
       if cogsa.blank?

   expenseforcogs =   eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=','Expense']])[0]
    eval(current_user.database.name.upcase.to_s)::AccountAccount.create(:name =>"CostOfGoodsSold",:code =>"CostOfGoodsSold",:type =>@acpyctypeco,:user_type =>cogs,:parent_id =>expenseforcogs)
       end
logger.info 32              

    #######################
    # AccountAccountType.create(:name =>"NonPosting",:code =>"NonPosting",:report_type =>"liability",:close_method =>"balance")
    count = 1
         account.each do |item|
       logger.info "nameeeeeeeeeeeeeeeeeeeee"  
       logger.info item.Name
       #oldac = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["name","ilike",item.Name]])[0] 
       # oldac = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["code","=", item.AccountNumber]])[0] 
  logger.info "i am blank"
  logger.info "i am blank"
  logger.info item.AccountNumber
  logger.info item.AccountNumber.class
  logger.info "accountnumberrrr"
  if item.AccountNumber.blank?
     item.AccountNumber = item.ListID
     item.save
  end
  oldac = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([["quickbook_id","=",item.ListID]])[0]
     logger.info oldac
     logger.info oldac.class
      logger.info "i 555555am increasing a count"
    logger.info count
    count = count + 1
   if oldac.blank? 
          self.create_an_account(current_user,item)
   else
    logger.info "this account is already there and needs to be updated means call here a function for updation of account"
    logger.info "i am increasing a count"
    logger.info count
    count = count + 1
    # at first import this should not come here 
        self.update_an_account(current_user,item,oldac)
   end
   
 end
   end
  
  
 
    def self.create_journal(current_user)
      
     if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Cr"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Cr"
     nec.code = "QB_Cr"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","sale/purchase journal view"]])[0]
     nec.type = 'sale'
     nec.save
     end
     if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Dr"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Dr"
     nec.code = "QB_Dr"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","sale/purchase journal view"]])[0]
     nec.type = 'purchase'
     nec.save
     end
     
     if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Bk"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Bk"
     nec.code = "QB_Bk"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","Bank/Cash Journal View"]])[0]
     nec.type = 'bank'
     nec.save
     end
     if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Ch"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Ch"
     nec.code = "QB_Ch"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","Bank/Cash Journal View"]])[0]
     nec.type = 'cash'
     nec.save
     end
    if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Ex"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Ex"
     nec.code = "QB_Ex"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","sale/purchase journal view"]])[0]
     nec.type = 'purchase'
     nec.save
     end
    if eval(current_user.database.name.upcase.to_s)::AccountJournal.search([["name","=","Quick_Book_Cn"]])[0].blank?
     nec = eval(current_user.database.name.upcase.to_s)::AccountJournal.new
     nec.name = "Quick_Book_Cn"
     nec.code = "QB_Cn"
     #nec.view_id = eval(current_user.database.name.upcase.to_s)::AccountJournalView.search([["name","ilike","sale/purchase Refund journal view"]])[0]
     nec.type = 'sale_refund'
     nec.save
     end
     
  
    end
    
    
    def self.create_an_account(current_user,item)
      logger.info "i am already created but again creating"   
      ac = eval(current_user.database.name.upcase.to_s)::AccountAccount.new
      ac.code = item.AccountNumber
      ac.quickbook_id = item.ListID  
      logger.info "i am blank"
      #if eval(current_user.database.name.upcase.to_s)::AccountAccount.find(:all, :domain=>[['code','=',item.AccountNumber.to_s]]).blank?
         logger.info "sssssssssss"
       #if its blank then it might be a active false so here i need to check by name if its exist then need to check
      # then assign a list id as code 
      logger.info "checking the name"
      logger.info "yes i am blank"
      ac.name = item.FullName
      ac.active = true
      ac.level = item.Sublevel
      ac.note = item.Description
      ac.currency_mode = "current"
      ac.reconcile = false
    if !item.ParentRef_FullName.blank?
     pid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=', item.ParentRef_FullName]])[0] 
     ac.parent_id = pid 
    else
     parent_id = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',item.AccountType]])[0]   # For Asset
      ac.parent_id =   parent_id  
    end
   if !item.AccountType.blank?
    actype = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=', item.AccountType]])[0]
    if !actype.blank?
      ac.user_type = actype
    else
     actype = eval(current_user.database.name.upcase.to_s)::AccountAccountType.new
     actype.name = item.AccountType 
     actype.code = item.AccountType 
     actype.close_method = "none"
     actype.save
     ac.user_type = actype.id
    end
   end
   
   if item.AccountType == "AccountsReceivable"
     ac.type = "receivable"
     ac.close_method = 'unreconciled'
     actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","AccountsReceivable"]])[0]
     ac.user_type = actyid
   elsif item.AccountType == "AccountsPayable"
      ac.type = "payable"
      ac.close_method = 'unreconciled'
      actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","AccountsPayable"]])[0]
      ac.user_type = actyid
   elsif item.AccountType == "Bank" 
      ac.type = "liquidity"
      actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","Bank"]])[0]
      ac.user_type = actyid
   elsif   item.AccountType == "Check" 
       actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","Check"]])[0]
      ac.user_type = actyid
   else
     #what first condition i need to put here is if the account has any reference in a parentlistid then the type is regular
     #or else the type is view
      aclitsid = item.ListID 
      checklistid = Account.where("ParentRef_ListID = '#{aclitsid}'")
      #if ac has a child then its type is view
      if checklistid[0].blank?
        
          checklistidoetype = Account.where("AccountType = \"#{item.Name}\" ")
        
         if checklistidoetype[0].blank?
           ac.type = "other"
         else
           ac.type = "view"
         end
          
        
        
          
      else
        ac.type = "view"
      end
          
   end
   
    
     
  
  logger.info " final code ...................for company got is ................"
  logger.info ac.code
  logger.info ac.code
  
 #here just need to check the account number in without active mode   
 #logger.info name_exist_array
 logger.info "aaaaaaaaaaa"
 
# if name_exist_array.include?(item.AccountNumber)
# else  
  ac.save
# end 
          
     
    end
    
    #i need to write an extra function for checking where an children account available or not 
    
    def check_child_or_not
      
    end
    
    
    
    def self.update_an_account(current_user,item,oldacid)
              logger.info "i am already created but again creatinguuuuuuuuuuuuuuuuuuuuuuuuu"   
      ac = eval(current_user.database.name.upcase.to_s)::AccountAccount.find(oldacid)
      ac.code = item.AccountNumber
      ac.quickbook_id = item.ListID  
      logger.info "i am blank"
      #if eval(current_user.database.name.upcase.to_s)::AccountAccount.find(:all, :domain=>[['code','=',item.AccountNumber.to_s]]).blank?
         logger.info "sssssssssss"
       #if its blank then it might be a active false so here i need to check by name if its exist then need to check
      # then assign a list id as code 
      logger.info "checking the name"
      logger.info "yes i am blank"
      ac.name = item.FullName
      ac.active = true
      ac.level = item.Sublevel
      ac.note = item.Description
      ac.currency_mode = "current"
      ac.reconcile = false
      
      
    if !item.ParentRef_FullName.blank?
     pid = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=', item.ParentRef_FullName]])[0] 
     ac.parent_id = pid 
    else
      #this is for sales a/c error . Error occurred while validating the field(s) type: Configuration Error!
##You cannot define children to an account with internal type different of "View".
     
      parent_id = eval(current_user.database.name.upcase.to_s)::AccountAccount.search([['name', '=',item.AccountType]])[0]   # For Asset
      ac.parent_id =   parent_id  
     
    end
    
      
   if !item.AccountType.blank?
    actype = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([['name', '=', item.AccountType]])[0]
    if !actype.blank?
      ac.user_type = actype
    else
     actype = eval(current_user.database.name.upcase.to_s)::AccountAccountType.new
     actype.name = item.AccountType 
     actype.code = item.AccountType 
     actype.close_method = "none"
     actype.save
     ac.user_type = actype.id
    end
   end
   if item.AccountType == "AccountsReceivable"
     ac.type = "receivable"
     ac.close_method = 'unreconciled'
     actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","AccountsReceivable"]])[0]
     ac.user_type = actyid
    elsif item.AccountType == "AccountsPayable"
      ac.type = "payable"
      ac.close_method = 'unreconciled'
      actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","AccountsPayable"]])[0]
      ac.user_type = actyid
    elsif item.AccountType == "Bank" 
      ac.type = "liquidity"
      actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","Bank"]])[0]
      ac.user_type = actyid
    elsif   item.AccountType == "Check" 
       #actyid = eval(current_user.database.name.upcase.to_s)::AccountAccountType.search([["name","=","Check"]])[0]
      ac.user_type = "liquidity"
   else
     
        
        aclitsid = item.ListID 
      checklistid = Account.where(" ParentRef_ListID = '#{aclitsid}'")
      #if ac has a child then its type is view
      if checklistid[0].blank?
          checklistidoetype = Account.where("AccountType = \"#{item.Name}\" ")
         if checklistidoetype[0].blank?
           ac.type = "other"
         else
           ac.type = "view"
         end
           
      else
        ac.type = "view"
      end
      
        
   end
    
     
  
  logger.info " final code ...................for company got is ................"
  logger.info ac.code
  logger.info ac.code
  
 #here just need to check the account number in without active mode   
 #logger.info name_exist_array
 logger.info "aaaaaaaaaaa"
 
# if name_exist_array.include?(item.AccountNumber)
# else  
  
  ac.save
  
  
# end 
          
     
    end
    

end
   
