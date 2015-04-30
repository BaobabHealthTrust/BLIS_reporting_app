class UserController < ApplicationController
  def login
    reset_session
  end

  def authenticate
    username = params[:user]["username"]
    password = params[:user]["password"]

    login_link = "#{CONFIG["order_transport_protocol"]}://#{username}:#{password}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_login"]}"

    remote_status = JSON.parse(RestClient.get(login_link))

    if (remote_status.to_s.match(/error/i) rescue false)
      flash[:error] = remote_status.to_s.gsub(/error|\{|\}/i, "")
      redirect_to "/user/login"
    else
      session[:user_token] = remote_status['token']
      session[:user] = remote_status['username']
      session[:user_person_names] = remote_status['name']
      redirect_to "/" and return
    end

  end

end
