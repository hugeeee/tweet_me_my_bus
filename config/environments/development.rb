TweetMeMyBus::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

	Twitter.configure do |config|
				config.consumer_key = 'CaePG6UQIlMjsWIVlycyw'
				config.consumer_secret = '6IU3EKExSgX5x0QCI3IEmCWLB4lhddpoO7Tz7IGZnI'
				config.oauth_token = '472855669-kgZFqYcxhc67jwNs4lmdLWprat0dDLUNRXPyxpYU'
				config.oauth_token_secret = 'F2zW6f4BnhFDktNN9OH8LXxHY4bfhWnvIOUXp6OAYhk'
			end

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
end

