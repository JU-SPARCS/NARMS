# == Schema Information
#
# Table name: airspace_segments
#
#  id          :integer          not null, primary key
#  pub_id      :string(255)
#  active      :boolean          default(TRUE)
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

class AirspaceSegment < ActiveRecord::Base
  include PublicIdentifier

  # Associations
  belongs_to :facility, required: true

  # Validations
  # Callbacks
end
