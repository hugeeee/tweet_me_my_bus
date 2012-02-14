require 'savon'
require 'nori/parser/nokogiri'
#require 'rubygems'
require 'twitter'

task :send_alert => :environment do
	dm_exception = 'The user is not following the app'

	client = Savon::Client.new do
		wsdl.document = "http://textmemybus.com:8180/TextMyBusSite/services/TextMyBusService?wsdl"
	end

	response = client.request :get_bus_stop_arrival_predictions

	# get data from xml
	data = response.to_hash[:get_bus_stop_arrival_predictions_response][:get_bus_stop_arrival_predictions_return]

	# this parses nested xml
	intermediate_data = Nori::Parser::Nokogiri.parse data 

	# this is the array of all buses in xml
	buses = intermediate_data[:bus_stop_arrival_predictions][:bus_stop_arrival_prediction]

	# store the users that need to be alerted in a list
	@users_to_notify = []

	# get the current time
	@current_time = Time.now

	# method to determine period of the week
	def day_of_week
		if @current_time.wday == 0 || @current_time.wday == 6
			week_period = "Weekends"
		else
			week_period = "Weekdays"
		end
		
	end

	@time_of_the_week = day_of_week

	# loop thru the soap response and query the alerts due to be sent
	buses.each do |bus|
		# parse the time in from soap field
		time_of_arrival = Time.parse  bus[:arrival_time]

		# subtract from the current time
		dif = (time_of_arrival - @current_time)/ 60

		# round off the difference
		@arriving_in = dif.ceil
		puts @arriving_in

		# query the db for users with alerts for the bus, stop and time
		
		##########################
		# TODO: use stop name rather than stop id ######################################## DONE!
		##########################
		users = User.alerts_to_be_sent(bus[:scheduled_bus_route_code], Alert::STOPS[:bus_stop_id], @time_of_the_week, @arriving_in)

		# adds bus and stop that the user needs to be alerted for
		users.each do |i|
			i.user_alert_bus = bus[:scheduled_bus_route_code]
			i.user_alert_stop = Alert::STOPS[:bus_stop_id]
		end

		# add to the users that will be alerted
		# give user an instance of an alert bus. set it to nil then set the attr with stop id and route
		#puts users.nil?
		if !users.empty?
			@users_to_notify + users
		end

	end

	Twitter.configure do |config|
		config.consumer_key = 'CaePG6UQIlMjsWIVlycyw'
		config.consumer_secret = '6IU3EKExSgX5x0QCI3IEmCWLB4lhddpoO7Tz7IGZnI'
		config.oauth_token = '472855669-kgZFqYcxhc67jwNs4lmdLWprat0dDLUNRXPyxpYU'
		config.oauth_token_secret = 'F2zW6f4BnhFDktNN9OH8LXxHY4bfhWnvIOUXp6OAYhk'
	end

	############
	#####		SEND OUT THE ALERTS FROM HERE
	############

=begin
	threads = []

	# loop thru the users and send the alerts using twitter api
	@users_to_notify.each do |user|
		#threads << Thread.new do
			puts user.class
			begin
				Twitter.direct_message_create(user.twitter, "Your bus will be arriving soon o.O")
			rescue Twitter::Error::Unauthorized => dm_exception
				# what to do in the rescue of a failed message		
			end

		#end
	end
	#threads.each(&:join)

=end


end

