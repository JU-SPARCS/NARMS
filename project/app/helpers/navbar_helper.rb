# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module LogEventsHelper

      # Depending on the role of the User, the navigation bar will look differently.
      # This method returns the tabs that a User can see, in the format of a map with (key,value) pairs
      # where key is the tab name, and value is the tab link.
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
