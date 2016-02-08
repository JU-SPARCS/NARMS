# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  pub_id     :string(255)
#  active     :boolean          default(TRUE)
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Facility < ActiveRecord::Base
  has_many :worker_profiles, dependent: :destroy
  has_many :workstations, dependent: :destroy
end