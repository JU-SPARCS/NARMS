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
#  facility_id   :integer
#  user_id       :integer
#

class WorkerProfile < ActiveRecord::Base
  include PublicIdentifier

  # Associations
  belongs_to :user
  belongs_to :facility, required: true
  has_and_belongs_to_many :shifts, dependent: :destroy
  has_many :schedules, class_name: Schedules::Worker, dependent: :destroy
  has_many :log_events, class_name: Events::Log, dependent: :destroy

  # Validations
  validates_presence_of :user, if: ->() { !new_record? }

  # Callbacks

  def get_schedules_over_period(start_at, end_at)
  	schedules.where("end > ? AND begin < ?", start_at, end_at).order(:begin)
  end
end
