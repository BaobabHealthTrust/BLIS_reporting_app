class ConfigController < ApplicationController

  def index
   
  end

  def user_accounts

    users_link = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_users"]}"
    data = RestClient.get(users_link) rescue nil

    @users = []
    @users = JSON.parse(data) if !data.blank?

    lab_sections_link = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_lab_sections"]}"
    data_ls = RestClient.get(lab_sections_link) rescue nil

    @lab_sections = []
    @lab_sections = JSON.parse(data_ls) if !data_ls.blank?
  end

  def post_data
    @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["user_create_or_edit_link"]}"

    response = RestClient.post(@post_url, params)

    render :text => response
  end
end
