# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module LogEventsHelper

      def visible_tabs
        if current_user
          return {'Home' => '/base', 'Shifts' => '/shifts', 'My Schedules' => '/worker_schedules', 'My Log Events' => '/log_events'}
        else
          return {}
        end
      end

    end

    helpers LogEventsHelper
  end
end
