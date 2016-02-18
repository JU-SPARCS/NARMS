# == Schema Information
#
# Table name: schedule_slots_workers
#
#  id               	:integer          not null, primary key
#  begin       			:datetime
#  end       			:datetime
#  created_at       	:datetime
#  updated_at       	:datetime
#  schedules_worker_id	:integer
#

class ScheduleSlots::Worker < ActiveRecord::Base
  # Associations
  belongs_to :schrole_idedule,
    class_name: Schedules::Worker,
    foreign_key: :schedules_worker_id,
    required: true

  # Validations
  validates_presence_of :begin
  validates_presence_of :end

  # Callbacks
end
