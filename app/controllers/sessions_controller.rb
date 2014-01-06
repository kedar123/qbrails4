class SessionsController < Devise::SessionsController
  
  
  
  def new
    super
     
  end
  
    # POST /resource/sign_in
    #here what i have to assume that 
    #its seems to be here the working is when an the authentication is not done then it will not go ahead
    #of authenticate line so above that i will check for weather an email is exist or not.
    #if its exist then the error is of password else the error may be of password or email.
    #first situation is email is correct and password is wrong.
    #so here i need to show an error of password
    #second situation is email is incorrect and password is also incorrect.
    #instead of doing all these things what i need to do is if there is an error just show an error
    #message under fields
  def create
    
    resource = warden.authenticate!(auth_options)
    
     
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    
    sign_in(resource_name, resource)
   
    respond_with resource, :location => after_sign_in_path_for(resource)
  end
  
end
