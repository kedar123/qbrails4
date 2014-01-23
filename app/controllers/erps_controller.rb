
class ErpsController < ApplicationController
  # GET /erps
  # GET /erps.json
  layout 'prof'
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

     respond_to do |format|
       notice = 'OpenERP Connection established successfully'
        begin
           @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
           pc=eval(current_user.database.name.upcase.to_s)::ResCompany.first
           logger.info pc.name
           logger.info "this is to see a connection can be established"
           #the above line is for make sure that connection established successfully
        rescue=>e
          logger.info "the connection was unsuccessful"
          logger.info 
          notice = 'Can not connect to OpenERP please check details again'
        end  
       if current_user.save  and notice == 'OpenERP Connection established successfully'
         format.html { redirect_to  erp_path(current_user.erp), :notice=> notice }
         format.json { render :json=> @erp, :status=> :created, :location=> @erp }
       else
        format.html { render :action=> "new",:notice=>notice }
        format.json { render :json=> @erp.errors, :status=> :unprocessable_entity }
      end
    end
    
  end

  # PUT /erps/1
  # PUT /erps/1.json
  def update
     @erp = Erp.find(params.require(:id))
    respond_to do |format|
      if @erp.update_attributes(erp_params)
        notice = 'OpenERP Connection established successfully'
         begin
           @ooor = Ooor.new(:url => "http://"+current_user.erp.url+":#{current_user.erp.port}/xmlrpc", :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password,:scope_prefix => current_user.database.name.upcase.to_s)
           pc=eval(current_user.database.name.upcase.to_s)::ResCompany.first
           logger.info pc.name
           logger.info "this is to see a connection can be established"
           #the above line is for make sure that connection established successfully
        rescue=>e
          logger.info "the connection was unsuccessful"
          logger.info 
          notice = 'Can not connect to OpenERP please check details again'
        end
        p "before render"
        p notice
        if notice == 'Can not connect to OpenERP please check details again'
            @notice = 'Can not connect to OpenERP please check details again'
           format.html { render :action=> "edit" , :notice=> notice}
        else
         format.html { redirect_to @erp, :notice=> notice }
        end
         format.json {render  :head =>:no_content }
      else
        #
        format.html { render :action=> "edit" }
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
