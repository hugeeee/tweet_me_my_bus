#require 'savon'
#require 'nori/parser/nokogiri'
#require 'rubygems'
require 'twitter'

	task :send_alert => :environment do

	dm_exception = 'The user is not following the app'
	user = User.first
	#puts "the user is called #{user.name}"

	Twitter.configure do |config|
		config.consumer_key = 'CaePG6UQIlMjsWIVlycyw'
		config.consumer_secret = '6IU3EKExSgX5x0QCI3IEmCWLB4lhddpoO7Tz7IGZnI'
		config.oauth_token = '472855669-kgZFqYcxhc67jwNs4lmdLWprat0dDLUNRXPyxpYU'
		config.oauth_token_secret = 'F2zW6f4BnhFDktNN9OH8LXxHY4bfhWnvIOUXp6OAYhk'
	end	

	begin
		Twitter.direct_message_create(user.twitter, "Hello #{user.name}. I have been sent from heroku")
	rescue Twitter::Error::Unauthorized => dm_exception
		
	end

	
end

