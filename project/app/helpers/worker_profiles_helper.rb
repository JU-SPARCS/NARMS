# == Schema Information
#
# Table name: worker_profiles
#
#  id            :integer          not null, primary key
#  pub_id        :string(255)
#  active        :boolean          default(TRUE)
#  name          :string(255)
#  first_name    :string(255)
#  date_of_birth :datetime
#  created_at    :datetime
#  updated_at    :datetime
#  facility_id   :integer
#  user_id       :integer
#

# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module WorkerProfilesHelper
      # def simple_helper_method
      # ...
      # end
    end

    helpers WorkerProfilesHelper
  end
end
