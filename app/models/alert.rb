class Alert < ActiveRecord::Base

	belongs_to :user

	attr_accessible :bus_route, :stop, :first_alert, :second_alert, :third_alert, :active

	validates :bus_route, :presence => true
	validates :stop, :presence => true

	validates :first_alert, :presence => true, :numericality => {:only_integer => true}
	validates :second_alert, :presence => true, :numericality => {:only_integer => true}
	validates :third_alert, :presence => true, :numericality => {:only_integer => true}

end
