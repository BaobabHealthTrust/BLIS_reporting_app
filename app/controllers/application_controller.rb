class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery 
    
  before_filter :perform_basic_auth, :except => ['login','authenticate']

  def admin?
    User.current.level == 2
  end

  protected

  def perform_basic_auth
    if session[:user_id].blank?
      #respond_to do |format|
        #format.html { redirect_to '/login' }
      #end
    elsif not session[:user_id].blank?
      #User.current = User.where(:'id' => session[:user_id]).first
    end
  end

end
