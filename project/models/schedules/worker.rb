class Schedules::Worker < ActiveRecord::Base
  # Associations
  belongs_to :worker_profile, required: true
  has_many :slots,
    class_name: ScheduleSlots::Worker

  # Validations
  validates_presence_of :begin
  validates_presence_of :end

  # Callbacks
end