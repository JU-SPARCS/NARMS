# == Schema Information
#
# Table name: schedules_workers
#
#  id                :integer          not null, primary key
#  begin_at          :datetime
#  end_at            :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  worker_profile_id :integer
#

class Schedules::Worker < ActiveRecord::Base
  # Associations
  belongs_to :worker_profile, required: true
  has_many :slots,
    class_name: ScheduleSlots::Worker,
    foreign_key: :schedules_worker_id

  # Validations
  validates_presence_of :begin_at
  validates_presence_of :end_at

  # Callbacks

  def map_slots_to_log_events
    slots_and_logs = Hash.new[
      slots.map { |s| [(s.begin_at..s.end_at), pair_slot_and_events(s)] }
    ]

    worker_profile.log_events.where(happened_at: begin_at..end_at).find_each do |log|
      log_range = log.to_slot_time_range
      if slots_and_logs.has_key? log_range
        slots_and_logs[log_range][:events] << log
      else
        slots_and_logs[log_range] = pair_slot_and_events(nil, log)
      end
    end

    slots_and_logs
  end

  private

  def pair_slot_and_events(slot = nil, *events)
    { slot: slot, events: events }
  end

end
