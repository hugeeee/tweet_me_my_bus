class AlertsController < ApplicationController

before_filter :correct_user, :only => [:update, :edit, :destroy]

  def new
		@alert = Alert.new
		@title = "Create new alert"

  end

	def create
		@alert = Alert.new(params[:alert])
		if @alert.save
			# save the alert
		end

		# maybe do something else
	end

end
