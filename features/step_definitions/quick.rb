#now i am doing all the testing by keeping in mind that turbolinks are working properly
require 'watir-webdriver'
When(/^I am On Root Page Of Home Index$/) do
  p "expressing thingsssss"
  #what first test i need to do is 
  #first i will add validations on sign up page . and then check from here for sign up.
  #i changed a sign up page validations.now the testing is like this.user visit a web site.
  #then click on free redirected to a sign in page then click on sign up page then redirected to a registration page.
  #then after registration. user automatically sign in. then click on free data migration. then click on database creation link
  #then click on next then click on openerp data migration. and start a migration
  #then next testing is of user sign in and immedietly sign out.and after immedietly sign in there should be a link present.
  #pending # express the regexp above with the code you wish you had

  b = Watir::Browser.new
  b.goto 'http://localhost:3000'
 
  b.a(:href => "/payments/index?id=free").click
  sleep 3
  b.a(:href => "/users/sign_up").click
  b.text_field(:id=>"user_email").set("kedar13@gmaill.com")
  b.text_field(:id=>"user_password").set("kedar123")
  b.text_field(:id=>"user_password_confirmation").set("kedar123")
  b.text_field(:id=>"country").set("kedar123")
  b.text_field(:id=>"state").set("kedar123")
  b.text_field(:id=>"street").set("kedar123")
  b.text_field(:id=>"zip_code").set("kedar123")
  b.text_field(:id=>"mobile").set("9763370419")
  b.text_field(:id=>"phone").set("9763370419")
  b.text_field(:id=>"address").set("9763370419")
  b.button(:id => 'startmigration_button').click
  #sign in successfull 
  
  b.button(:text => " Here ").click
  #the down functions will be copied to another test file because. i need to put a manual step betn as i need to 
  #migrate a 
  b.a(:text => "Next").click
  b.a(:text => "Next").click
  b.a(:text => "Next").click
  #b.button(:id => 'startmigration_button').click
  #now need to give local openerp details

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #b.select_list(:id => 'company_id').select 'Your Company'
  #b.button(:id => 'go').click
  #b.element(:text=>"Please enter the dates of your stay to check availability")
  #b.text_field(:id=>"checkin").set("09/17/2013 00:00")
  #b.text_field(:id=>"checkout").set("09/26/2013 00:00")
  #b.text_field(:id=>"checkin").set("10/01/2013 00:00")
  #b.text_field(:id=>"checkout").set("10/09/2013 18:28") 

end
