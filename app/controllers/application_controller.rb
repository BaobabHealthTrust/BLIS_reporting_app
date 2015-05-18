class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  #protect_from_forgery
    
  before_filter :check_user, :except => ['login','authenticate', 'tb_report', 'tb_report_mq']

  def admin?
    User.current.level == 2
  end

  protected

  def check_user

    if session[:user_token].blank?
      redirect_to '/user/login' and return
    else
      auth_link = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_login_check"]}?token=" + session[:user_token] + "&username=" + session[:user]

      auth_status = JSON.parse(RestClient.get(auth_link))

      if auth_status[0].to_s == "true"
        return true
      else
        redirect_to "/user/login" and return
      end
    end
  end

end
