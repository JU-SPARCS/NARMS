# == Schema Information
#
# Table name: airspace_segments
#
#  id         :integer          not null, primary key
#  pub_id     :string(255)
#  active     :boolean          default(TRUE)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

RSpec.describe AirspaceSegment do
  pending "add some examples to (or delete) #{__FILE__}"
end
