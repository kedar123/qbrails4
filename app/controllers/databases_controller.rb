
class DatabasesController < ApplicationController
  #before_filter :authenticate_user!
  before_filter :check_user_signin
  #user_signed_in?  
  # GET /databases
  # GET /databases.json
  
  
  
  def index
 
    @databases = Database.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json=> @databases }
    end
  end

  # GET /databases/1
  # GET /databases/1.json
  def show
    @database = Database.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json=> @database }
    end
  end

  # GET /databases/new
  # GET /databases/new.json
  def new
    @database = Database.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json=> @database }
    end
  end

  # GET /databases/1/edit
  def edit
    @database = Database.find(params[:id])
  end

  # POST /databases
  # POST /databases.json
  def create
    current_user.user_payment_choice = params[:id]
    current_user.save
    if current_user.database.blank?
    @database = Database.new(params[:database])
    @database.name = 'database'
    @database.save
    @database.name = @database.name + @database.id.to_s
    @database.user_id = current_user.id
    @database.save
    Database.create_default_schema(@database)  
       
     respond_to do |format|
      if @database.save
        format.html { redirect_to home_index_path, :notice=> 'Database was successfully created.' }
        format.json { render :json=> @database, :status=>:created, :location=> @database }
      else
        format.html { render :action=> "new" }
        format.json { render :json=> @database.errors, :status=> :unprocessable_entity }
      end
    end
    else
      redirect_to home_index_path, :notice=> 'Database was Already created.'
    end
  end

  # PUT /databases/1
  # PUT /databases/1.json
  def update
    @database = Database.find(params[:id])

    respond_to do |format|
      if @database.update_attributes(params[:database])
        format.html { redirect_to @database, :notice=> 'Database was successfully updated.' }
        format.json { render :head => :no_content }
      else
        format.html { render :action=> "edit" }
        format.json { render :json=> @database.errors, :status=> :unprocessable_entity }
      end
    end
  end

  # DELETE /databases/1
  # DELETE /databases/1.json
  def destroy
    @database = Database.find(params[:id])
    @database.destroy

    respond_to do |format|
      format.html { redirect_to databases_url }
      format.json {render :head => :no_content }
    end
  end
  
  
  private
  def check_user_signin
    
        if !user_signed_in?
           redirect_to new_user_session_path
        end
      
  end
  
  
end
