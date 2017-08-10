require 'spec_helper'
require 'watir'
describe Client do
  describe "#authorization" do


     context "given right login and password" do
     	it "successfull authorization" do
     	 client = Client.new("dualist.lp@mail.ru","penpen13")
     	 browser = client.browser
     	 client.authorization
    	 expect(browser.span(class: 'header-ts__profile__username js-head-user-name').text).to eql("DUALIST.LP@MAIL.RU")
    	end
	 end

     context "given wrong login or password" do
     	it "successfull authorization" do
     	 client = Client.new("dualist.lp@mail.ru","asdasd")
     	 browser = client.browser
     	 client.authorization
    	end
	 end
  end
  #describe "#create_ad_unit" do 
  	#before do
  	#	 client = Client.new("dualist.lp@mail.ru","penpen13")
     #	 browser = client.browser
   #  	 client.authorization
 #   end

  		
end