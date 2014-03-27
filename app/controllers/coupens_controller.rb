class CoupensController < ApplicationController
  before_action :set_coupen, only: [:show, :edit, :update, :destroy]
  before_filter :check_admin

  # GET /coupens
  # GET /coupens.json
  def index
    @coupens = Coupen.all
  end

  # GET /coupens/1
  # GET /coupens/1.json
  def show
  end

  # GET /coupens/new
  #here i need to keep a coupen in a session because in browser an user can change a coupen which i dont want.
  #so instead of session in view i am creating a hidden field and keeping a value in it.
  def new
     @coupen = Coupen.new
     value = "" 
     50.times{value  << (65 + rand(25)).chr}
     #here at value character i need to add at last a coupen id + 1 numeric value
     #so that it will be always a unique also to make concurrent user uniqueness i am adding an user ipaddress at last
     #
     coupen_id = Coupen.last.id
     #because of this coupen_id its always a unique thing.
    
     @coupenvalue = value.to_s + coupen_id.to_s + request.ip
  end
  
  def generate_a_uniq_coupen
    
  end
  

  # GET /coupens/1/edit
  def edit
  end

  # POST /coupens
  # POST /coupens.json
  def create
    @coupen = Coupen.new(coupen_params)
    respond_to do |format|
      #as in model the coupen is unique so if its try to duplicate then it will redirect to new page again.
      #the problem here is if 2 user demands it commonly then it might be a problem.so again in new for creating
      #here first i need to test weather an user changed an coupen value or not or not.if its changed then 
      #redirect to new again with saying coupen value is invalid
       if params[:coupenvalue] == params[:coupen][:coupen]
         if @coupen.save
          format.html { redirect_to @coupen, notice: 'Coupen was successfully created.' }
          format.json { render action: 'show', status: :created, location: @coupen }
        else
          format.html { render action: 'new' }
          format.json { render json: @coupen.errors, status: :unprocessable_entity }
        end
      else
          format.html { redirect_to new_coupen_path,notice: 'Coupen was Invalid' }
      end
     end
  end

  # PATCH/PUT /coupens/1
  # PATCH/PUT /coupens/1.json
  def update
    respond_to do |format|
      if @coupen.update(coupen_params)
        format.html { redirect_to @coupen, notice: 'Coupen was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @coupen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coupens/1
  # DELETE /coupens/1.json
  def destroy
    @coupen.destroy
    respond_to do |format|
      format.html { redirect_to coupens_url }
      format.json { head :no_content }
    end
  end
  
  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coupen
      @coupen = Coupen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupen_params
      params.require(:coupen).permit(:coupen)
    end
    
    def check_admin
        if current_user
          if current_user.email == "sales@pragtech.co.in"
          else
            redirect_to root_path ,:notice=>"Admin Can Generate A Coupon"
          end
        else
             redirect_to root_path ,:notice=>"Admin Can Generate A Coupon"
        end 
    end
    
end
