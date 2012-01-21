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
			#@user = User.find(params[:user_id])
			redirect_to current_user
		end

		# maybe do something else
	end

	def update
		@alert = User.alerts.find(params[:id])
    if @alert.update_attributes(params[:user])
      flash[:success] = "Alert updated."
      redirect_to @user
    else
      @title = "Edit Alert"
      render 'edit'
    end

	end

	def destroy
		
	end

end
