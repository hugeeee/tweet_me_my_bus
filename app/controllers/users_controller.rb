class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def new
		@user = User.new
		@title = "Sign up"
	end

	# this method creates a new user if details are entered correctly.
	# and also signs the user in.
	def create
		@user = User.new(params[:user])
		if @user.save
		sign_in @user
		flash[:success] = "Welcome to Tweet Me My Bus!"
		redirect_to @user
		else
		@title = "Sign up"
		render 'new'
		end
	end
end
