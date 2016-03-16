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
#  workstation_id        :integer
#  worker_profile_id     :integer
#  event_type            :string(255)
#

class Events::Log < ActiveRecord::Base
  belongs_to :worker_profile, required: true
  belongs_to :workstation, required: true

  def to_slot_time_range
    begin_at = happened_at.floor 30.minutes
    begin_at..(begin_at + 30.minutes)
  end
end
