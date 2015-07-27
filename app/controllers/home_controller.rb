class HomeController < ApplicationController
  def index


    url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_actions"]}?action=stat_counts"

    dt = RestClient.get(url)

    @data = JSON.parse(dt) rescue dt

    url2 = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_actions"]}?action=point_to_point_average_times"

    dt2 = RestClient.get(url2)

    @graph_data = JSON.parse(dt2) rescue dt2

  end

  def active_stats

    url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_states"]}"

    dt = RestClient.get(url)

    cur_states = JSON.parse(dt)

    render :text => cur_states.to_json

  end
end
