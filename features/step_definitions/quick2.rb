#this file is for standard testinggggggggg

When(/^I am On Root Page Of Home Index standard$/) do
   #so for premium the situation is different and its includes paypal integration.
   #the first link is for making an login to paypal
  b = Watir::Browser.new 
  b.goto 'https://developer.paypal.com/webapps/developer/applications/accounts'
  b.link(:text=>"Log In").click
  b.window(:title => "Log In Using Your PayPal Account").use do
  b.text_field(:id=>"email").set("kedar.pathak@pragtech.co.in")
  b.text_field(:id=>"password").set("kedar123")
  b.button(:name=>"_eventId_submit").click
  end
  
  b.windows.first.use
  b.goto 'http://localhost:3000/'
  b.a(:href => "/payments/index?id=standard").click
  sleep 2
  b.a(:href => "/users/sign_up").click
  sleep 3
  b.text_field(:id=>"user_email").set("kedar17@gmaill.com")
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
   
  b.a(:href => "/payments/checkout").click
  sleep 2
  b.text_field(:id=>'login_email').set('test@pragtech.co.in')
  b.text_field(:id=>'login_password').set('kedar123')
  b.button(:id=>'submitLogin').click
  b.button(:id=>'continue_abovefold').click
  b.button(:value=>"Complete Payment").click
  b.button(:text => " Here ").click
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
  if ((b.text.match(/^OpenERP Connection established successfully$/) == nil ))
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
  
  

  
  
end
