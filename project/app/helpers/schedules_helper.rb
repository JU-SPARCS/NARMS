# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module SchedulesHelper
    	def sendTo
          puts "*********************** YES ****"
    	end
    end

    helpers SchedulesHelper
  end
end
