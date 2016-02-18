# == Schema Information
#
# Table name: schedules_workers
#
#  id               	:integer          not null, primary key
#  begin       			:datetime
#  end       			:datetime
#  created_at       	:datetime
#  updated_at       	:datetime
#  worker_profile_id	:integer
#

class Schedules::Worker < ActiveRecord::Base
  # Associations
  belongs_to :worker_profile, required: true
  has_many :slots,
    class_name: ScheduleSlots::Worker,
    foreign_key: :schedules_worker_id

  # Validations
  validates_presence_of :begin
  validates_presence_of :end

  # Callbacks
end
