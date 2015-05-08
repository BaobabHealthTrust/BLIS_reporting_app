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

  def test_types

    test_types_link = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_tables"]}?table_type=test_types"

    @data = RestClient.get(test_types_link) rescue nil

    test_status_link = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_tables"]}?table_type=disabled_status"

    @disabledTests = JSON.parse(RestClient.get(test_status_link)) rescue nil

  end

  def post_data

    if params[:post_type] == "test_type"
      @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_test_type_save"]}"
    else
      @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["user_create_or_edit_link"]}"
    end

    response = RestClient.post(@post_url, params)

    render :text => response
  end

  def test_type_edit_popup

    tables = ['measures_data',  'test_type_input_info', 'compatible_specimens']
    response = {}

    tables.each do |table|

      @ttype_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_tables"]}?table_type=#{table}&tid=#{params['tid']}"
      data = RestClient.get(@ttype_url)

      response[table] = JSON.parse(data) rescue data
    end

    render :text => response.to_json
  end

  def test_type_disable

    url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_actions"]}?action=test_type_disable&tid=#{params['tid']}&enable=#{params['enable']}"

    dt = RestClient.get(url)
    data = JSON.parse(dt) rescue dt
    render :text => data.to_json
  end
end
