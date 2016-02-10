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
#

require 'spec_helper'

RSpec.describe WorkerProfile do
  pending "add some examples to (or delete) #{__FILE__}"
end
