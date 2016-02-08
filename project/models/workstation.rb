# == Schema Information
#
# Table name: workstations
#
#  id         :integer          not null, primary key
#  pub_id     :string(255)
#  active     :boolean          default(TRUE)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Workstation < ActiveRecord::Base
  belongs_to :facility, required: true
end
