#!/usr/bin/ruby
require 'rubygems'
require 'twitter'
 
oauth = Twitter::OAuth.new('CaePG6UQIlMjsWIVlycyw', '6IU3EKExSgX5x0QCI3IEmCWLB4lhddpoO7Tz7IGZnI')
oauth.authorize_from_access('472855669-ateCqePq13afjn32tbMhYCGVB89oAybR47XHXo63', 'SDMenE7dd9QOhkxazMwWYbtMcJ8LdTrHMsk1f6TOc')
 
client = Twitter::Base.new(oauth)
client.update('first tweet, this is a test')