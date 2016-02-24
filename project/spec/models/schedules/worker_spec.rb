# == Schema Information
#
# Table name: schedules_workers
#
#  id                :integer          not null, primary key
#  begin             :datetime
#  end               :datetime
#  created_at        :datetime
#  updated_at        :datetime
#  worker_profile_id :integer
#

require 'spec_helper'

RSpec.describe Schedules::Worker do
  pending "add some examples to (or delete) #{__FILE__}"
end
