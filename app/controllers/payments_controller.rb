class PaymentsController < ApplicationController
  
  include ActiveMerchant::Billing
  before_filter :authenticate_user! 
  def index
    
    current_user.user_payment_choice = params[:id]
    current_user.save
    
    if current_user.user_payment_choice == "free"
      redirect_to root_path ,:notice=>"Please Create Database"
    end 
    
    if current_user.user_payment_choice == "standard"
        @amount = 199    
    elsif current_user.user_payment_choice == "premium"
        @amount = 999
    end
    
  end

  def confirm
  end

  def complete
  end
  
  #checkout is depend on the type user has selected.that is free,standard,premium
  #so suppose its a free then. instead of checkout just redirect him to a migration page
  #otherwise its seems to be an paypal redirection as user clicked on paypal and he cames here then 
  #an old checkout method because giving an timeout error
  def checkoutl
   
    
  begin 
  setup_response = gateway.setup_purchase(50,
    :items => [{:name => "Quick Book Migration", :description => "All Modules",:amount=> 50}], 
    :ip                => request.remote_ip,
    :return_url        => url_for(:action => 'confirm', :only_path => false),
    :cancel_return_url => url_for(:action => 'index',:id=>current_user.user_payment_choice , :only_path => false),
    :allow_guest_checkout=> true
   )
   
   
  redirect_to gateway.redirect_url_for(setup_response.token)
  rescue=>e
    logger.info "some errors in active merchant"
    logger.info e.inspect
    redirect_to :back ,:notice=>"There Are Some Errors In Connection Please Try Again"
  end
  end
  
  def checkout
       if current_user.user_payment_choice == "standard"
          @amount = 199*100    
       elsif current_user.user_payment_choice == "premium"
          @amount = 999*100
       end
    
    response = EXPRESS_GATEWAY.setup_purchase(@amount,
    ip: request.remote_ip,
    return_url: url_for(:action => 'confirm', :only_path => false),
    cancel_return_url: url_for(:action => 'index',:id=>current_user.user_payment_choice , :only_path => false),
    currency: 'USD',
    locale: I18n.locale.to_s.sub(/-/, '_'), #you can put 'en' if you don't know what it means :)
    brand_name: 'Pragmatic', #The name of the company
    header_image: 'http://pragtech.co.in/images/logo.png',
    allow_guest_checkout: false,   #payment with credit card for non PayPal users
    items: [{:name => "Quick Book Migration", :description => "All Modules",:amount=> @amount}] #array of hashes, amount is a price in cents
  )
   
  redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  
  
  def confirm
    if current_user.user_payment_choice == "standard"
          @amount = 199*100    
       elsif current_user.user_payment_choice == "premium"
          @amount = 999*100
       end
    redirect_to :action => 'index' unless params[:token]

    details_response = gateway.details_for(params[:token])

    if !details_response.success?
      @message = details_response.message
      logger.info details_response.inspect
      render :action => 'error'
      return
    end

    @address = details_response.address
  end
  
  def complete
    
       if current_user.user_payment_choice == "standard"
          @amount = 199*100    
       elsif current_user.user_payment_choice == "premium"
          @amount = 999*100
       end
    purchase = gateway.purchase(@amount,
      :ip       => request.remote_ip,
      :payer_id => params[:payer_id],
      :token    => params[:token]
    )

    if !purchase.success?
      @message = purchase.message
      logger.info purchase.inspect
      render :action => 'error'
      return
      #just check here that current user is available
      #
        current_user.payment_status = true
        current_user.save
      
    else
        current_user.payment_status = true
        current_user.save
        redirect_to root_path ,:notice=>"Your Payment Is Successful Please See The Step To Create A Database"
    end
  end
  
  
  def payment_authorize
      transaction = AuthorizeNet::AIM::Transaction.new('34jttcC4G2TZ', '57Z6x4N5Pe3GpA7x', :gateway => :sandbox)
      credit_card = AuthorizeNet::CreditCard.new(params[:x_card_num], params[:x_exp_date])
      @credit_card = AuthorizeNet::CreditCard.new('4111111111111111', '01' + (Time.now + (3600 * 24 * 365)).strftime('%y'))
      response = transaction.purchase(params[:amount], @credit_card)
      logger.info response.inspect
      logger.info "sssssssssssssssssssssssssssssssss"
      if response.success?
          #after a successful transaction an person is need to redirect to a root page for creating
          #a database.
         current_user.payment_status = true
         current_user.save
         redirect_to root_path ,:notice=>"Your Payment Is Successful Please See The Step To Create A Database"
      else
          
           redirect_to :back ,:notice=>"There Are Some Errors In Payments Please Try Again"
      end
  end
  
  
  
  def coupen_check
     
       cp = Coupen.find_by_coupen(params[:coupen])
       if cp.blank?
         redirect_to :back ,:notice=>"Invalid Coupen"
       else
         current_user.coupenassigned = params[:coupen]
         current_user.save
         
         redirect_to root_path ,:notice=>"Your Coupen Is Valid Please See The Step To Create A Database"
       end
       
  end
  
  
private

  def gateway
        @gateway ||= PaypalExpressGateway.new(
           :login => 'kedar.pathak-facilitator_api1.pragtech.co.in',
          :password => '1364994877',
          :signature => 'ACLa8jsQN8TPFLDY57dLNb5-3qq.AgN5u20e33t3nrXP3uDzoZTGNERk'
        )
  end

 # def gateway
 #       @gateway ||= PaypalExpressGateway.new(
 #          :login => 'kedar.pathak-facilitator_api1.pragtech.co.in',
 #         :password => '1364994877',
 #         :signature => 'ACLa8jsQN8TPFLDY57dLNb5-3qq.AgN5u20e33t3nrXP3uDzoZTGNERk'
 #       )
 # end
 #def gateway
 #       @gateway ||= PaypalExpressGateway.new(
 #          :login => 'paypal_api1.pragtech.co.in',
 #         :password => 'V996T2LW3QBLPZFB',
 #         :signature => 'AFcWxV21C7fd0v3bYYYRCpSSRl31ATdQOOCe1m3eBpjpnp7dZ6rE22q5'
 #       )
 # end
  
 # def gateway
 #       @gateway ||= PaypalExpressGateway.new(
 #          :login => "kedarrpathak2001_api1.yahoo.com",
 #         :password => "BU84RVBTFDQYSK6L",
 #         :signature => "ARzJcWvnZBmQcxIhLmAWLxAOUxPCAmt.qcUu3839O7fqLNCaTyEIqIM0"
 #       )
 # end

  
  
end
