class SessionsController < ApplicationController

  def new
    redirect_to '/auth/memberful'
  end

  def create
    auth = request.env["omniauth.auth"]
    user = find_user_with_omniauth(auth) || User.new
    user.attributes_from_omniauth = auth
    user.save
    reset_session
    session[:user_id] = user.id
    redirect_to root_url, :notice => welcome_message(user)
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

  private

  def find_user_with_omniauth(auth)
    User.where(provider: auth.provider, uid: auth.uid.to_s).first
  end

  def create_user_with_omniauth(auth)
    @new_user = true
    User.create_with_omniauth(auth)
  end

  def welcome_message(user)
    if @new_user
      "Welcome, #{user.first_name}. Hope you enjoy our site!"
    else
      "Welcome back, #{user.first_name}!"
    end
  end

end
