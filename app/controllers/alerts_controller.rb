class AlertsController < ApplicationController

before_filter :correct_user, :only => [:update, :edit, :destroy]

	# create instance of alert model
	# set the title of the view
  def new
		@alert = Alert.new
		@title = "Create new alert"

  end

	# creates new alert and saves in db
	def create
		@alert = current_user.alerts.build(params[:alert])
		
		if @alert.save
			# save the alert
			#@user = User.find(params[:user_id])
			redirect_to current_user
		end

		# maybe do something else
	end

	def edit
    @title = "Edit alert"
		@alert = Alert.find(params[:id])
  end


	def update
		@alert =	Alert.find(params[:id])
    if @alert.update_attributes(params[:alert])
      flash[:success] = "Alert updated."
      redirect_to current_user
    else
      @title = "Edit Alert"
      render 'edit'
    end

	end

	# this will delete an alert
	def destroy
    Alert.find(params[:id]).destroy
    flash[:success] = "Alert deleted."
    redirect_to current_user
	end

	private

	# not sure about this
	def correct_user
			@alert = Alert.find(params[:id])
      @user = User.find(@alert.user_id)
      redirect_to(root_path) unless current_user?(@user)
  end

end
