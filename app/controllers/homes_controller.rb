class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]

  # GET /homes
  # GET /homes.json
  def index
     
       # p Database.connection
  #here i need to write a code just for a test a test is like to check 
# p Database.connection
 @databaseimport = "incomplete"
 
   if user_signed_in?
    if current_user
      @databaseimport = check_database_successfully_import
       if !current_user.erp.blank?
         @erp = current_user.erp
       #    @ooor = Ooor.new(:url => current_user.erp.url, :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password)
        #import = Import.new
        #import.delay(:queue => 'tracking').call_start_import
       else
         @erp = Erp.new
       end
    end
   else
     #this i copied because sometimes i seen an wrong user logged in
   @erp = Erp.new
     #redirect_to new_user_session_path and return
   end
  
   
   
   
  end
  
  def check_database_successfully_import
      begin
         Database.connection.execute("use #{current_user.database.name}")
       if Company.count == 0
          
        Database.connection.execute("use mysqlquickbook")
        return "incomplete"
       end
       if Account.count == 0
          
        Database.connection.execute("use mysqlquickbook")
         return "incomplete"
       end
       if Customer.count == 0
          
        Database.connection.execute("use mysqlquickbook")
        return "incomplete"
       end
       if Vendor.count == 0
         
        Database.connection.execute("use mysqlquickbook")
        return "incomplete"
       end
       if Employee.count == 0
         
        Database.connection.execute("use mysqlquickbook")
         return "incomplete"
       end
       #for products i am assuming that at least 5 products are there.
      if((Itemsalestax.count + Itemsalestaxgroup.count + Itemservice.count + Itemdiscount.count + Itemfixedasset.count + Itemgroup.count + Iteminventory.count + Itemnoninventory.count + Iteminventoryassembly.count + Iteminventoryassembly.count + Itemothercharge.count + Itempayment.count + Itemsubtotal.count ) < 6    )
         
        Database.connection.execute("use mysqlquickbook")
         return "incomplete"
       end
       rescue => e
        logger.info "the error messageggegegege"
        logger.info e.inspect
        Database.connection.execute("use mysqlquickbook")
      ensure
        Database.connection.execute("use mysqlquickbook")
       end
    #if its come out from begin rescue then i need to send a response as complete
      Database.connection.execute("use mysqlquickbook")
       return "complete"
       #incomplete
  end
  

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)

    respond_to do |format|
      if @home.save
        format.html { redirect_to @home, notice: 'Home was successfully created.' }
        format.json { render action: 'show', status: :created, location: @home }
      else
        format.html { render action: 'new' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to @home, notice: 'Home was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url }
      format.json { head :no_content }
    end
  end
  
  def show_means
    render :layout=>false
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params[:home]
    end
end
