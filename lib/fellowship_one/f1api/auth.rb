module FellowshipOneAPI
  # From f1.yml
  class Auth
    class << self

      # Public access to authorize
      def authorize
        load_consumer
        load_access_token
      end

      private

      def load_consumer
        if @consumer.nil?
          consumer_key = Configuration.consumer_key
          consumer_secret = Configuration.consumer_secret
          site = Configuration.site
          request_token_path = Configuration.request_token_path
          access_token_path = Configuration.access_token_path
          authorize_path = Configuration.portal_authorize_path

          @consumer = OAuth::Consumer.new(
            consumer_key,
            consumer_secret,
            {
              site: site,
              request_token_path: request_token_path,
              access_token_path: access_token_path,
              authorize_path: authorize_path
            }
          )
        end

        @consumer
      end

      def load_access_token
        load_consumer if @consumer.nil?

        user = Configuration.auth_username
        pass = Configuration.auth_password
        portal_credential_token_path = Configuration.portal_credential_token_path # "/v1/PortalUser/AccessToken"
        cred = URI::encode(Base64.encode64("#{user} #{pass}"))

        headers = {
          "Content-Type" => "application/x-www-form-urlencoded"
        }

        if @access_token.nil?
          resp = @consumer.request(:post, portal_credential_token_path, nil, {}, "ec=#{cred}", headers)
          if FellowshipOneAPI::Util.check_response(resp)
            @access_token = ::OAuth::AccessToken.from_hash(@consumer, parse_access_token(resp.body))
          end
        end
        @access_token
      end

      # Parse returned OAuth access token key/secret pair
      def parse_access_token(response)
        oauth_hash = {}
        response.split('&').each do |val|
          kv = val.split('=')
          oauth_hash.merge!({kv[0].to_sym => kv[1]})
        end
        oauth_hash
      end
    end
  end
end
