class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
layout 'prof'
  # GET /homes
  # GET /homes.json
  def index
    
       # p Database.connection
  #here i need to write a code just for a test a test is like to check 
# p Database.connection
   if user_signed_in?
    if current_user
       if !current_user.erp.blank?
         
       #    @ooor = Ooor.new(:url => current_user.erp.url, :database => current_user.erp.database, :username => current_user.erp.username, :password => current_user.erp.password)
        #import = Import.new
        #import.delay(:queue => 'tracking').call_start_import
       
       end
    end
   else
     #this i copied because sometimes i seen an wrong user logged in
   
     #redirect_to new_user_session_path and return
   end
  end

  
  def index2
    render :layout=>"prof"
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
