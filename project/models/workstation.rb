# == Schema Information
#
# Table name: workstations
#
#  id          :integer          not null, primary key
#  pub_id      :string(255)
#  active      :boolean          default(TRUE)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

class Workstation < ActiveRecord::Base
  belongs_to :facility, required: true
  has_many :log_events, class_name: Events::Log, dependent: :destroy
end
