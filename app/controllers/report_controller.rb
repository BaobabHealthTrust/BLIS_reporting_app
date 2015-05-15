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

  def tb_report_mq
    @year = params[:year].strip rescue Date.today.year;
    start_date = params[:start_date].to_date
    end_date = params[:end_date].to_date

    @months = (start_date..end_date).map{ |m| m.strftime('%Y%m') }.uniq.map{ |m| [ m[/^\d\d\d\d/ ].to_i, Date::ABBR_MONTHNAMES[ m[/\d\d$/ ].to_i ], m[/\d\d$/ ].to_i] }
    @headers =  @months.collect{|m| "#{m[1].to_s}, #{m[0].to_s}"}

    @rows = ['Total suspects Examined', 'Total Sputum examined', 'Suspects Sputum Smear Positive',
             'Total of category unknown', 'Suspects who submit 2 sputum containers',
             'Follow-ups +ve at 4 and 6 months', 'Pick up rate']

    @rowsG = ['Total cases done on G.XPERT', 'Total HIV positive who are sputum -ve and -ve on G.XPERT',
              'Total HIV +ve who sputum smear -ve and are +ve on G.XPERT',
              'Total specimen on G.XPERT from ward', 'Total number of Cartridges used']

    @numerics = {}
    @numericsG = {}

    #initialize values
    @rows.each do |rw|
      @headers.each_with_index do |h, i|
        next if h.blank?
        year = @months[i][0]
        mon = @months[i][2]

        @numerics["#{year}#{mon}"] = {} if @numerics["#{year}#{mon}"].blank?
        @numerics["#{year}#{mon}"][rw] = 0
      end
    end

    @rowsG.each do |rw|
      @headers.each_with_index do |h, i|
        next if h.blank?
        year = @months[i][0]
        mon = @months[i][2]

        @numericsG["#{year}#{mon}"] = {} if @numericsG["#{year}#{mon}"].blank?
        @numericsG["#{year}#{mon}"][rw] = 0
      end
    end

    url = "#{CONFIG["order_transport_protocol"]}://#{CONFIG["order_username"]}:#{CONFIG["order_password"]}@#{CONFIG["order_server"]}:#{CONFIG["order_port"]}#{CONFIG["order_server_tables"]}?table_type=tb_report_mq&start_date=" + start_date.to_s + "&end_date=" + end_date.to_s

    data = RestClient.get(url)
    @data = JSON.parse(data) rescue data

    @data.each do |d|
      mon = d['mon'].to_i
      year = d['yr'].to_i
      result = d['result'].strip
      total = d['total'].to_i

     if d['test_name'].match("Sputum Tb microscopy")

      @numerics["#{year}#{mon}"]['Total Sputum examined'] += total
      @numerics["#{year}#{mon}"]['Suspects Sputum Smear Positive'] += total if result.match(/\++|scanty|positive|present/i)

     elsif d['test_name'].match("Xpert MTB/RIF")

      @numericsG["#{year}#{mon}"]['Total cases done on G.XPERT'] += total

    end

    @numerics["#{year}#{mon}"]['Total suspects Examined'] += total
    end

  end
end
