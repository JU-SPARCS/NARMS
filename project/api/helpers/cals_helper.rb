# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class Api
    module CalsHelper
      def ensure_identified_by_token!(token)
        error 403 if !(@facility && @facility.has_matching_token?(token))
      end
    end

    helpers CalsHelper
  end
end
