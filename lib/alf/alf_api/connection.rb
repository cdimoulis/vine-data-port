module AlfAPI
  # From f1.yml
  class Connection
    class << self

      def request(method, model_name, path=nil, data)
        case method.downcase
        when 'get'
          get model_name, path, data
        else
          puts "\nYeah we're not bothering with #{method} for this\n"
        end
      end

      # A get requests
      # limit = number of records
      # offset = starting record
      # id = the name of the attribute using tos earch
      # id_value = the desired value of the attribute
      def get(model_name, path=nil, data=nil)
        data ||= {}
        uri = URI.parse("#{Configuration.site}#{path || Configuration.api_path}")
        if data['table_name'].nil?
          data['table_name'] = model_name
        end
        uri.query = URI.encode_www_form data

        begin
          response = Net::HTTP.get uri
        rescue Exception => ex
          puts "\n\nGet Exception in AlfAPI::Connection - #{ex.inspect}"
          puts "\nData: #{model_name} - #{data.inspect}\n\n"
          puts "Attempting request again..."
          return get(model_name, path, data)
        end
        if response.present?
          resp = JSON.parse(response)
          records = resp[model_name]
        end
        # puts "\n\nRESPONSE #{records.length}\n\n"
        # records.each do |r|
        #   puts "#{r.inspect}\n"
        # end
        records
      end

    end
  end
end
