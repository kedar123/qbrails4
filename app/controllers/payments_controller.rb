class PaymentsController < ApplicationController
  include ActiveMerchant::Billing
   
  def index
    
    current_user.user_payment_choice = params[:id]
    current_user.save
    
    if current_user.user_payment_choice == "free"
      redirect_to :back,:notice=>"Please Go Through Steps At Bottom"
    end 
    
    
  end

  def confirm
  end

  def complete
  end
  
  #checkout is depend on the type user has selected.that is free,standard,premium
  #so suppose its a free then. instead of checkout just redirect him to a migration page
  #otherwise its seems to be an paypal redirection as user clicked on paypal and he cames here then 
  def checkout
  setup_response = gateway.setup_purchase(6000,
    :items => [{:name => "Quick Book Migration", :quantity => 1,:description => "All Modules",:amount=> 6000}], 
    :ip                => request.remote_ip,
    :return_url        => url_for(:action => 'confirm', :only_path => false),
    :cancel_return_url => url_for(:action => 'index', :only_path => false)
  )
  redirect_to gateway.redirect_url_for(setup_response.token)
  end

  def confirm
    redirect_to :action => 'index' unless params[:token]

    details_response = gateway.details_for(params[:token])

    if !details_response.success?
      @message = details_response.message
      render :action => 'error'
      return
    end

    @address = details_response.address
  end
  
  def complete
    purchase = gateway.purchase(6000,
      :ip       => request.remote_ip,
      :payer_id => params[:payer_id],
      :token    => params[:token]
    )

    if !purchase.success?
      @message = purchase.message
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
      transaction = AuthorizeNet::AIM::Transaction.new('483qQaLD', '9X9PvMKT22jj74cS', :gateway => :sandbox)
      credit_card = AuthorizeNet::CreditCard.new(params[:x_card_num], params[:x_exp_date])
      response = transaction.purchase(params[:amount], credit_card)
      logger.info response.inspect
      logger.info "sssssssssssssssssssssssssssssssss"
      if response.success?
          #suppose user come to this page  after a successful transaction happens that is reservation is done after he click on back button and
          #the a session of checkin date is blank which gives an error.
          #
          redirect_to :back ,:notice=>"Successful Transaction"
      else
         p response.inspect
         p "response.inspectttttt"
           redirect_to :back ,:notice=>"There Are Some Errors In Payments Please Try Again"
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
  
end
