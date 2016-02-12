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
end
