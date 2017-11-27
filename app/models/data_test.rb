class DataTest < ActiveRecord::Base

  def self.auth
    user = "f1data"
    pass = "Password#1"
    consumer_key = "162"
    consumer_secret = "dd265054-fd54-436c-97ee-2c191571d268"
    site = "https://vccmdhil.fellowshiponeapi.com"
    request_token_path = "/v1/Tokens/RequestToken"
    access_token_path = "/v1/Tokens/AccessToken"
    authorize_path = "/v1/PortalUser/Login"
    portal_crediential_token_path = "/v1/PortalUser/AccessToken"

    cred = URI::encode(Base64.encode64("#{user} #{pass}"))

    headers = {
      "Content-Type" => "application/x-www-form-urlencoded"
    }

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

    resp = @consumer.request(:post, portal_crediential_token_path, nil, {}, "ec=#{cred}", headers)

    @access_token = ::OAuth::AccessToken.from_hash(@consumer, DataTest.parse_access_token(resp.body))
  end

  def self.get_data(route, group=nil, type='.json', data=nil)
    if group.present?
      path = "/#{group}/v1#{route}#{type}"
    else
      path = "/v1#{route}#{type}"
    end
    if data.present?
      path += '?'+data
    end
    response = @access_token.request(:get, path)
    puts "\n\nStatus: #{response.code.to_i} #{}\n\n"
    # puts "\n\nBody: #{response.body.inspect}\n\n"
    if (200..299).include?(response.code.to_i)
      results = JSON.parse(response.body)
      results.each do |r|
        puts "#{r}\n"
      end
    else
      raise "Invalid response #{response.code.to_i}\n#{response.inspect}"
    end
  end

  private

  # Parse returned OAuth access token key/secret pair
  def self.parse_access_token(response)
    oauth_hash = {}
    response.split('&').each do |val|
      kv = val.split('=')
      oauth_hash.merge!({kv[0].to_sym => kv[1]})
    end
    oauth_hash
  end
end
