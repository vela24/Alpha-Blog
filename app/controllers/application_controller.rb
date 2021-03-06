class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
      if session[:user_id]
	    #reference current user if we have it, if not then find user by session user id
        @current_user ||= User.find(session[:user_id])
	  end
  end
  

  def logged_in?
  # turn current user into boolean
    !!current_user
  end

  def require_user
    if !logged_in?
    	flash[:alert] = "You must be logged in to perform that action"
    	redirect_to login_path
    end
  end


end
