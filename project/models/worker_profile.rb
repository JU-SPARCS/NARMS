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
#

class WorkerProfile < ActiveRecord::Base
  belongs_to :facility, required: true
end
