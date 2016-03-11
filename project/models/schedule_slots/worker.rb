# == Schema Information
#
# Table name: schedule_slots_workers
#
#  id                  :integer          not null, primary key
#  begin_at            :datetime
#  end_at              :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  schedules_worker_id :integer
#

class ScheduleSlots::Worker < ActiveRecord::Base
  # Associations
  belongs_to :schedule,
    class_name: Schedules::Worker,
    foreign_key: :schedules_worker_id,
    required: true

  # Validations
  validates_presence_of :begin
  validates_presence_of :end

  # Callbacks

  def to_slot_time_range
    slot_begin_at = begin_at.floor(30.minutes)
    slot_end_at = slot_begin_at + 30.minutes
    slot_begin_at..slot_end_at
  end
end
