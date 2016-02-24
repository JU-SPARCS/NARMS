# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  begin       :datetime
#  end         :datetime
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

# Helper methods defined here can be accessed in any controller or view in the application

module Narms
  class App
    module ShiftsHelper
      # def simple_helper_method
      # ...
      # end
    end

    helpers ShiftsHelper
  end
end
