module FellowshipOneAPI
  # From f1.yml
  class Connection
    class << self

      def request(method, path, group=nil, *args)
        load_connection if @connection.nil?
        req_path = "/#{Configuration.api_version}#{path}"
        if group.present?
          req_path = "/#{group}#{req_path}"
        end
        begin
          response = @connection.request(method, req_path, *args)
        rescue Exception => ex
          puts "\nThere was a connection error for #{method} #{path} #{args}\nError: #{ex.message}\nAttempting to reconnect...\n"
          # reaload the connection in case of timeout
          load_connection
          puts "Reconnected. Attempting request...\n"
          response = @connection.request(method, req_path, *args)
        end
        if Util.check_response(response)
          response
        end
      end

      private

      def load_connection
        @connection = Auth.authorize
      end

    end
  end
end
