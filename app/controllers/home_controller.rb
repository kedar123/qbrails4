
class HomeController < ApplicationController
  
  #here i need to start the delayed job service at background because here i assume that 
  #the erp details are there
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
      #p "but import is doneee"
       end
    end
   else
     #this i copied because sometimes i seen an wrong user logged in
   
     redirect_to new_user_session_path and return
   end
    
    
    
  end
  
  
  def actree
    
  end
  
  
end
