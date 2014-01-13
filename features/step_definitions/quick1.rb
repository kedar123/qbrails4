require 'watir-webdriver'
When(/^I am On Root Page Of Home Index1$/) do
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
  b.goto 'http://localhost:3000/'
 
  b.a(:href => "/payments/index?id=free").click
   
  b.text_field(:id=>"user_email").set("kedar135@gmail.com")
  b.text_field(:id=>"user_password").set("kedar123")
   
  b.button(:id => 'startmigration_button').click
  #sign in successfull 
  #b.button(:text => " Here ").click
  #the down functions will be copied to another test file because. i need to put a manual step betn as i need to 
  #migrate a 
  #here a database is already created
  b.a(:text => "Next").click
  b.a(:text => "Next").click
  b.a(:text => "Next").click
  b.button(:id => 'startmigration_button').click
  #now need to give local openerp details
  b.text_field(:id=>"erp_database").set("quickbooktest50")
  b.text_field(:id=>"erp_username").set("admin")
  b.text_field(:id=>"erp_password").set("admin")
  b.text_field(:id=>"erp_url").set("127.0.0.1")
  b.text_field(:id=>"erp_port").set("8069")
  b.button(:value=>"Done").click
  if ( (b.text.match(/^OpenERP Connection established successfully$/) == nil ))
    #this step is for making an correction in erp details
  b.text_field(:id=>"erp_database").set("quickbooktest50")
  b.text_field(:id=>"erp_username").set("admin")
  b.text_field(:id=>"erp_password").set("admin")
  b.text_field(:id=>"erp_url").set("127.0.0.1")
  b.text_field(:id=>"erp_port").set("8069")
  b.button(:value=>"Done").click
  b.button(:value=>"Start Migration").click
  else
    b.button(:value=>"Start Migration").click
  end
  
  
  
  #b.select_list(:id => 'company_id').select 'Your Company'
  #b.button(:id => 'go').click
  #b.element(:text=>"Please enter the dates of your stay to check availability")
  #b.text_field(:id=>"checkin").set("09/17/2013 00:00")
  #b.text_field(:id=>"checkout").set("09/26/2013 00:00")
  #b.text_field(:id=>"checkin").set("10/01/2013 00:00")
  #b.text_field(:id=>"checkout").set("10/09/2013 18:28") 

end
