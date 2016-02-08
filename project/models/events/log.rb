# == Schema Information
#
# Table name: events_logs
#
#  id                    :integer          not null, primary key
#  happened_at           :datetime
#  worker_role           :string(255)
#  worker_responsability :string(255)
#  operational_status    :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class Events::Log < ActiveRecord::Base
  belongs_to :worker_profile, required: true
  belongs_to :workstation, required: true
end
