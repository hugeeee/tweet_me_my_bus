class AlertsController < ApplicationController

before_filter :correct_user, :only => [:update, :edit, :destroy]

  def new
		@alert = Alert.new
		@title = "Create new alert"

  end
####
## Problem might be with the user_id
####
	def create
		@alert = current_user.alerts.build(params[:alert])
		if @alert.save
			# save the alert
			redirect_to @user
		end

		# maybe do something else
	end

	def update

	end

	def destroy
		
	end

end
