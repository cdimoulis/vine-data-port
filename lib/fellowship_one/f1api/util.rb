module FellowshipOneAPI
  # From f1.yml
  class Util
    class << self

      def check_response(response)
        case response.code.to_i
        when (200..299)
          true
        when (300..399)
          # redirect
          # TODO: actually redirect instead of throwing error
          response.error!
          false
        when (400..499)
          raise OAuth::Unauthorized, response
          false
        else
          response.error!
          false
        end
      end
    end
  end
end
