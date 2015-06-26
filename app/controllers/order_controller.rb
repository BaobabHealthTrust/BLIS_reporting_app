class OrderController < ApplicationController
  def index

    @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_search_path"]}"

    data = RestClient.get(@post_url)

    @data = JSON.parse(data) rescue data

  end

  def pull_orders

    @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_search_path"]}"

    data = RestClient.post(@post_url, {"search_string" => params[:search_string]})

    @data = JSON.parse(data) rescue data

    render :text => @data.to_json
  end

  def order_popup

    render :text => {}.to_json  if params[:spec_id].blank?

    @post_url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["single_order_search_path"]}"

    data = RestClient.post(@post_url, {"specimen_id" => params[:spec_id]})

    @data = JSON.parse(data) rescue data

    render :text => @data.to_json
  end
end
