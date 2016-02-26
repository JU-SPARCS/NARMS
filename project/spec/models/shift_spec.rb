# == Schema Information
#
# Table name: shifts
#
#  id          :integer          not null, primary key
#  begin       :datetime
#  end         :datetime
#  name        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  facility_id :integer
#

require 'spec_helper'

RSpec.describe Shift do
  pending "add some examples to (or delete) #{__FILE__}"
end
