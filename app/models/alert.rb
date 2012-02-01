class Alert < ActiveRecord::Base

	# this class is not fully implemented
	belongs_to :user
			
	attr_accessible :bus_route, :stop, :first_alert, :second_alert, :third_alert, :active, 
								:days_of_notification, :user_id
	
	# checking fields are present
	validates :bus_route, :presence => true
	validates :stop, :presence => true
	validates :days_of_notification, :presence => true

	# check form fields are present and integers
	validates :first_alert, :presence => true, :numericality => {:only_integer => true}
	validates :second_alert, :presence => true, :numericality => {:only_integer => true}
	validates :third_alert, :presence => true, :numericality => {:only_integer => true}

	validates :user_id, :presence => true

	def users_to_notify (bus_route, stop, alert_time)
		# pull down the users that have alerts due
	end

	ROUTES = ["Dublin", "Wexford"]
	DAYS = ["Weekdays", "Weekends", "Everyday"]
	STOPS = ["Gorey", "Enniscorthy", "UCD"]

end
