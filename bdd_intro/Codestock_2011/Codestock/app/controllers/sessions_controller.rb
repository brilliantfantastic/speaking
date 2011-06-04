class SessionsController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    authenticate!
    if logged_in?
      redirect_to :root
    end
  end
  
  def unauthenticated
    flash[:error] = "Incorrect email/password combination"

    redirect_to new_session_url
    return false
  end
  
end