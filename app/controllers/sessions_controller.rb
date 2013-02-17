class SessionsController < ApplicationController
  before_filter :signed_out_user, only: [:create, :new]
  
  def new
  end

  def create
  	user = User.find_by_email(params[:email].downcase)
  	if user && user.authenticate(params[:password])
  		sign_in user
  		redirect_back_or user
  	else
  		flash.now[:error] = 'Invalid email/password combination'
  		render 'new'
  	end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end

private

  def signed_out_user
        redirect_to user_path(current_user), notice: "already logged in" if signed_in?
  end