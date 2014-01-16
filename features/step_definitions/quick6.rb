require 'watir-webdriver'
require "watir-webdriver/extensions/alerts"


When(/^I am On Sign Up Page\.$/) do
   
  
  #here i need to test all the validations for a sign up page.
  b = Watir::Browser.new 
  b.execute_script "window.onbeforeunload = null"
  b.goto 'http://localhost:3000/'
  
  b.a(:href => "/payments/index?id=free").click
  
  sleep 3
  b.a(:href => "/users/sign_up").click
  p "77777777777777777777777"
  #click on submit button
  sleep 1
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Email").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Email"
  else
    exit
  end  
  #close the alert box
  #b.alert.ok
  b.alert.close
  #set a text field value
  b.text_field(:id=>"user_email").set("kedar.pathak48@pragtech.co.in") 
  sleep 1
   
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Password At Least 5 Digits").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Password At Least 5 Digits"
  else
    exit
  end  
  #close the alert box
  #b.alert.ok
  b.alert.close
  #set a text field value
  b.text_field(:id=>"user_password").set("kedar123") 
  sleep 1
   
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Password Dosent Match").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Password Dosent Match"
  else
    exit
  end  
  #close the alert box
  #b.alert.ok
  b.alert.close
  #set a text field value
  b.text_field(:id=>"user_password_confirmation").set("kedar123") 
  sleep 1
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Country").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Country"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"country").set("india") 
  sleep 1  
  
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter State").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter State"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"state").set("maharashtra") 
  sleep 1
  
  
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Street").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Street"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"street").set("karve road") 
  sleep 1
  
  
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Zip Code").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Zip Code"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"zip_code").set("411038") 
  sleep 1
  
  
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Mobile").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Mobile"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"mobile").set("9763370419") 
  sleep 1
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Phone").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Phone"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"phone").set("411038") 
  sleep 1
  
  
  #click on submit button
  b.button(:id=>"startmigration_button").click
  sleep 1
  #get the alert box value
  b.alert do
         b.button(:value => "Please Enter Address").click
       end #
  jatxt = b.alert.text     
  #check the alert box value
  if jatxt == "Please Enter Address"
  else
    exit
  end  
  #close the alert box
  b.alert.ok
  #b.alert.close
  #set a text field value
  b.text_field(:id=>"address").set("Address") 
  sleep 1
  b.button(:id=>"startmigration_button").click
  sleep 1
   if ( (b.text.match(/^Please Go Through Steps At Bottom/) == nil ))
      exit
   end
  
end
