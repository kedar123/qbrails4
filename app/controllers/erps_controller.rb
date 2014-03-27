
class ErpsController < ApplicationController
  # GET /erps
  # GET /erps.json
  require 'net/ping'
  def index
 
    @erps = Erp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @erps }
    end
  end

  # GET /erps/1
  # GET /erps/1.json
  def show
     
    @erp = Erp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @erp }
    end
  end

  # GET /erps/new
  # GET /erps/new.json
  def new
    logger.info "is this current user"
        #what i need to do here is if the database is not yet created then redirect back to root page.with a notice that please create
    #a database
    if current_user.database.blank?
       redirect_to root_path ,:notice=>"Please Create A Database In First Step." and return
    end
    
    if user_signed_in?
      if   current_user.erp.blank?
          @erp = Erp.new
    else
    @erp = current_user.erp
      
    end
    else
      redirect_to new_user_session_path and return
    end
    
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @erp }
    end
  end

  # GET /erps/1/edit
  def edit
    @erp = Erp.find(params[:id])
  end

  # POST /erps
  # POST /erps.json
  def create
    @erp = Erp.new(erp_params)
    current_user.erp = @erp
    
    good = current_user.erp.url
    p1 = Net::Ping::External.new(good)
    if !p1
        #from here return by notice saying that server is not up
        respond_to do |format|
          format.html { redirect_to  homes_path, :notice=> "Your Server Details Were Incorrect" }
        end
        
    else
     
      
     respond_to do |format|
       notice = 'OpenERP Connection established successfully'
        begin
          logger.info "nnnnnnnnn"
          logger.info notice
           @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
           logger.info @ooor
           pc=eval(current_user.database.name.upcase.to_s)::ResCompany.first
           logger.info pc.name
           logger.info "this is to see a connection can be established"
           #the above line is for make sure that connection established successfully
        rescue Exception => e
          logger.info "the connection was unsuccessful"
          logger.info 
          notice = 'Can not connect to OpenERP please check details again'
        ensure
         # notice = 'Can not connect to OpenERP please check details again'
          
        end  
       if current_user.save  and notice == 'OpenERP Connection established successfully'
         
           import = Import.new
            import.save
           if current_user.user_payment_choice == "free" 
              import.delay.export_free_migration(current_user)
              del=import.delay.inspect
              CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"free")
           elsif current_user.user_payment_choice == "standard" 
             import.delay.export_standard_migration(current_user)
             del=import.delay.inspect
             CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"standard")
           elsif current_user.user_payment_choice == "premium"
             import.delay.export_premium_migration(current_user)
             del=import.delay.inspect
             CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"premium")
           end
          
          notice = "Migration is started , you will shortly get an Email after Comletion of migration" 
          
         format.html { redirect_to  homes_path, :notice=> notice }
         format.json { render :json=> @erp, :status=> :created, :location=> @erp }
       else
        format.html { redirect_to  homes_path, :notice=> notice }
        format.json { render :json=> @erp.errors, :status=> :unprocessable_entity }
      end
    end
    end
    
  end

  # PUT /erps/1
  # PUT /erps/1.json
  def update
     @erp = Erp.find(params.require(:id))
     #here first i need to check weather the server is exist or not. if its not then return by a flash notice saying
     #that server is not exist.
     respond_to do |format|
      if @erp.update_attributes(erp_params)
        good = current_user.erp.url
        p1 = Net::Ping::External.new(good)
         notice = 'OpenERP Connection established successfully'
              if !p1.ping?
         #from here return by notice saying that server is not up
           notice =  "Your Server Details Were Incorrect" 
          else
         begin
           @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
           pc=eval(current_user.database.name.upcase.to_s)::ResCompany.first
           logger.info pc.name
           logger.info "this is to see a connection can be established"
           #the above line is for make sure that connection established successfully
        rescue Exception => e
          logger.info "the connection was unsuccessful"
          logger.info 
          notice = 'Can not connect to OpenERP please check details again'
         ensure 
          # notice = 'Can not connect to OpenERP please check details again'
        end
              end
        if notice == 'Can not connect to OpenERP please check details again'
            @notice = 'Can not connect to OpenERP please check details again'
           format.html { redirect_to homes_path, :notice=> notice}
        elsif notice ==  "Your Server Details Were Incorrect" 
              format.html { redirect_to homes_path, :notice=> notice}
        else
            import = Import.new
            import.save
           if current_user.user_payment_choice == "free" 
             
              import.delay.export_free_migration(current_user)
              #here i am creating an one table row for the purpose of creating a report
                 del=import.delay.inspect
                
              CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"free")
           elsif current_user.user_payment_choice == "standard" 
             import.delay.export_standard_migration(current_user)
             del=import.delay.inspect
             CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"standard")
           elsif current_user.user_payment_choice == "premium"
             import.delay.export_premium_migration(current_user)
             del=import.delay.inspect
             CreateJobs.create(:user_id=>current_user.id,:delayed_job_id=>del.id,:migration_type=>"premium")
           end
          
          notice = "Migration is started , you will shortly get an Email after Comletion of migration"  
         format.html { redirect_to homes_path, :notice=> notice }
        end
        
         format.json {render  :head =>:no_content }
      else
        #
        format.html { redirect_to homes_path, :notice=> notice }
        format.json { render :json=> @erp.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /erps/1
  # DELETE /erps/1.json
  def destroy
    @erp = Erp.find(params[:id])
    @erp.destroy

    respond_to do |format|
      format.html { redirect_to erps_url }
      format.json {render :head=>:no_content }
    end
  end
  
  #i am taking this controller for showing an steps to a user for starting a migration
  #step 1 is for ask an user to select an migration type.so that a database is get created.
  def step1
    
  end
  
  
  def erp_params
      params.require(:erp).permit(:database, :password, :url, :username,:user_id,:port,:id)
  end
  
  
end
