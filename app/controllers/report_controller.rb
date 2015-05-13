class ReportController < ApplicationController
  def index
  end

  def tb_report
      @year = params[:year].strip;
      start_date = "#{@year}-01-01"
      end_date = "#{@year}-12-31"

      @headers = ['', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      @rows = ['Total number examined', 'Total number of negatives', 'Total number of negative slides',
                  'Total number of positives', 'Total number of positive slides', 'Total number of slides used']
      @numerics = {}

      #initialize values
      @rows.each do |rw|
        @headers.each_with_index do |h, i|
          next if h.blank?
          @numerics[i] = {} if @numerics[i].blank?
          @numerics[i][rw] = 0
        end
      end

      url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_tables"]}?table_type=tb_report&year=#{@year}&start_date=" + start_date + "&end_date=" + end_date

      data = RestClient.get(url)
      @data = JSON.parse(data) rescue data

      @data.each do |d|
        next if !d['test_name'].match("Sputum Tb microscopy")
        mon = d['mon'].to_i
        result = d['result'].strip
        total = d['total'].to_i

        @numerics[mon]['Total number examined'] += total
        @numerics[mon]['Total number of negatives'] += total if result.match(/negative|absent/i)
        @numerics[mon]['Total number of positives'] += total if result.match(/\++|scanty|positive|present/i)
      end
  end
end
