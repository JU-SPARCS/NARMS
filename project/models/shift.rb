# == Schema Information
#
# Table name: shifts
#
#  id         	:integer          not null, primary key
#  begin      	:datetime
#  end     	  	:datetime
#  name       	:string(255)
#  created_at 	:datetime
#  updated_at 	:datetime
#  facility_id	:integer
#

class Shift < ActiveRecord::Base
  # Associations
  belongs_to :facility, required: true
  has_and_belongs_to_many :worker_profiles, dependent: :destroy

  # Validations
  validates_presence_of   :begin
  validates_presence_of   :end

  # Callbacks

  scope :from_worker_profile, ->(worker_profile){
  	joins("join shifts_worker_profiles on shifts.id = shifts_worker_profiles.shift_id")
      .where("shifts_worker_profiles.worker_profile_id = ?", worker_profile.id)
  }

  scope :over_period, ->(start_at, end_at){
      where("end > ? AND begin < ?", start_at, end_at)
  }
end
