require 'watir'
class Client
	attr_reader :browser
		
	#html attributes 
	AUTHORIZATION_LINK_HTML_CLASS = 'js-text ph-button__text ph-button__text_profilemenu ph-button__text_light ph-button__text_profilemenu_signin ph-button__text_left'
	LOGIN_BUTTON_HTML_CLASS = 'button button_submit'
	NEW_PAD_BUTTON_HTML_CLASS = 'pad-groups-control-panel__button pad-groups-control-panel__button_create'
	APP_NAME_HTML_CLASS = 'pad-setting__description__input js-setting-pad_description js-setting-field'
	APP_URL_HTML_CLASS = 'pad-setting__url__input js-setting-pad-url'
	URL_ERROR_HIDE_HTML_CLASS = 'pad-setting__url-error _gray-block js-setting-pad_url-error hide'
	URL_ERROR_HTML_CLASS = 'pad-setting__url-error _gray-block js-setting-pad_url-error'
	CREATE_AD_UNIT_BUTTON_HTML_CLASS = 'main-button-new js-main-button'
	AD_UNIT_LABEL_HTML_CLASS = 'pad-groups-list__link js-pad-groups-label'
	PAGINATOR_BUTTON_RIGHT_HTML_CLASS = 'paginator__button paginator__button_right js-control-inc'
	PAGINATOR_BUTTON_RIGHT_FALSE_HTML_CLASS = 'paginator__button paginator__button_right js-control-inc _disabled'
	WRONG_EMAIL_ALERT_HTML_CLASS = 'auth-popup__error js-auth-error'
	WRONG_LOGIN_OR_PASSWORD_HTML_CLASS = 'formMsg js_form_msg js_form_msg'
	#messages
	WRONG_LOGIN_OR_PASSWORD = 'Wrong login or password'
	WRONG_AD_UNIT_URL = 'Wrong url'
	SERVER_ERROR = 'Server error'
	SUCCESS = 'Success'

	def initialize(login, password)
		@login = login
		@password = password
		@browser = Watir::Browser.new :firefox
		Watir.default_timeout = 90
	end

	def authorizate()
		begin
			@browser.goto("https://target-sandbox.my.com/")
			puts "target"
			@browser.span(class: AUTHORIZATION_LINK_HTML_CLASS).wait_until_present
			puts "1"
			@browser.span(class: AUTHORIZATION_LINK_HTML_CLASS).click
			puts "2"
			@browser.text_field(name: "login").wait_until_present
			puts "3"
			@browser.text_field(name: "login").set @login
			puts "4"
			@browser.text_field(name: "password").set @password
			puts "5"
			@browser.button(class: LOGIN_BUTTON_HTML_CLASS).click
			puts "6"
		Watir::Wait.until { (browser.div(class: WRONG_EMAIL_ALERT_HTML_CLASS).present? || @browser.div(class: WRONG_LOGIN_OR_PASSWORD_HTML_CLASS).present? || @browser.link(class: NEW_PAD_BUTTON_HTML_CLASS).present?)}
			return WRONG_LOGIN_OR_PASSWORD if (browser.div(class: WRONG_EMAIL_ALERT_HTML_CLASS).present? || @browser.div(class: WRONG_LOGIN_OR_PASSWORD_HTML_CLASS).present?)
			@browser.button(class: LOGIN_BUTTON_HTML_CLASS).wait_while_present
		
		rescue Exception => e
			puts "error"
			return SERVER_ERROR
		end

		return SUCCESS
	end

	def create_ad_unit(name, url)
		begin
			@browser.goto("https://target-sandbox.my.com/create_pad_groups/")

			@browser.text_field(class: APP_NAME_HTML_CLASS).set name
				
			@browser.text_field(class: APP_URL_HTML_CLASS).set url
			
			Watir::Wait.until { (@browser.span(class: CREATE_AD_UNIT_BUTTON_HTML_CLASS).present? || @browser.div(class: URL_ERROR_HTML_CLASS).present?)}
			return WRONG_AD_UNIT_URL if @browser.div(class: URL_ERROR_HTML_CLASS).present?
			
			@browser.span(class: CREATE_AD_UNIT_BUTTON_HTML_CLASS).click
			
			paginator_right_last
			
			return SUCCESS if @browser.link(text: name, class: AD_UNIT_LABEL_HTML_CLASS ).exists?
		rescue Exception => e
			return SERVER_ERROR
		end
			return SERVER_ERROR
	end
	
	def get_all_ad_units
		@ad_units_count = -1;
		@ad_units = []
		loop do
			get_ad_units
			if @browser.div(class: PAGINATOR_BUTTON_RIGHT_FALSE_HTML_CLASS).exists?
				return 
			else 
				@browser.div(class: PAGINATOR_BUTTON_RIGHT_HTML_CLASS).click
				sleep(1)
			end
		end
		return @ad_units
	end
	
	private
	def paginator_right_last
		
		@browser.div(class: PAGINATOR_BUTTON_RIGHT_HTML_CLASS).wait_while_present
		loop do
			if @browser.div(class: PAGINATOR_BUTTON_RIGHT_FALSE_HTML_CLASS).exists?
				return 
			else 
				@browser.div(class: PAGINATOR_BUTTON_RIGHT_HTML_CLASS).click
				sleep(1)
			end
		end
	end

	def get_ad_units
		doc = Nokogiri::HTML.parse(@browser.html)
		doc.css('table').each do |table|
			@ad_units_count += 1
  			
  			table.css('tr')[2..-1].each do |tr|

   				cell_data = tr.css('td').map(&:text)
   				puts cell_data
   				@ad_units += [@ad_units_count, cell_data]
   			end
  		end
	end
end
