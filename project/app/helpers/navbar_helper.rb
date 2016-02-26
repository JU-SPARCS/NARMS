# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module NavBarHelper

      # Depending on the role of the User, the navigation bar will look differently.
      # This method returns the tabs that a User can see, in the format of a map with (key,value) pairs
      # where key is the tab name, and value is the tab link.
      def visible_tabs
        tabs = {}
        if current_user
          tabs = {
            # Tabs to put in the navbar. 
            'Home' => '/base',
            'Schedules' => '/schedules',
            'Working Places' => '/worker_profiles'
          }
        end

        return tabs
      end

      def current_theme
        default_theme = 'cosmo'
        current_theme = request.cookies['main-theme']
        selected_theme = current_theme ? current_theme : default_theme
        return {:name => selected_theme, :url => available_themes[selected_theme]}
      end

      def available_themes
        themes = {
          'cosmo' => "/app/css/bootstrap.cosmo.css",
          'cerulean' => "/app/css/bootstrap.cerulean.css",
          'cyborg' => "/app/css/bootstrap.cyborg.css",
          'darkly' => "/app/css/bootstrap.darkly.css",
          'lumen' => "/app/css/bootstrap.lumen.css",
          'sandstone' => "/app/css/bootstrap.sandstone.css",
          'spacelab' => "/app/css/bootstrap.spacelab.css"
        }
        return themes
      end

    end

    helpers NavBarHelper
  end
end
