class UserController < ApplicationController
  def login
    reset_session
  end

  def authenticate
    user = User.find_by_username params[:user]["username"]                   
    if not user.blank? and user.password_matches?(params[:user]["password"]) 
      session[:user_id] = user.user_id                                       
      redirect_to "/" 
    else                                                                      
      flash[:error] = 'That username and/or password was not valid.'          
      redirect_to '/login'
    end                                                                       
  end

end
