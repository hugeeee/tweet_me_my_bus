#!/usr/bin/ruby
require 'rubygems'
require 'twitter'
 
Twitter.configure do |config|
	config.consumer_key = 'CaePG6UQIlMjsWIVlycyw'
	config.consumer_secret = '6IU3EKExSgX5x0QCI3IEmCWLB4lhddpoO7Tz7IGZnI'
	config.oauth_token = '472855669-kgZFqYcxhc67jwNs4lmdLWprat0dDLUNRXPyxpYU'
	config.oauth_token_secret = 'F2zW6f4BnhFDktNN9OH8LXxHY4bfhWnvIOUXp6OAYhk'
end
 
Twitter.update("work!!!")
#client = Twitter::Base.new(oauth)
#client.update('checking if gem is here?!')
