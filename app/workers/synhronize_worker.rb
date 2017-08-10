 class SynhronizeWorker
  include Sidekiq::Worker

  sidekiq_options retry: false
  
  def perform(id)
  	@account = Account.find(id)
    @ad_units = @account.ad_units.where.not(status: 2)
    puts @ad_units
    @account.error_message =" "
    @account.status = 1
	@account.save
	client = Client.new(@account.login, @account.password)
	puts "authorization"
	@account.status = 2

	authorize_status = client.authorizate
	puts "authorization2"
	if (authorize_status == Client::SUCCESS)
      @ad_units.each do |ad_unit| 
	 
	    status = client.create_ad_unit(ad_unit.name,ad_unit.url)
	   
	   	if (status == Client::SUCCESS)
	   		ad_unit.status = 2
	   		ad_unit.error_message = ""
	   	else
	   		ad_unit.status = -1
	   		ad_unit.error_message = status
	   		@account.status = -1	
	   		@account.error_message = "Creation failed"
	   	end
	   	ad_unit.save
	  
	  end
	else
	  @account.status = -1
	  @account.error_message = "Wrong login or password"
	end
	
	client.browser.close
	@account.save
  
  end

end