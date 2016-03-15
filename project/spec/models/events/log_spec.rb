# == Schema Information
#
# Table name: events_logs
#
#  id                    :integer          not null, primary key
#  happened_at           :datetime
#  worker_role           :string(255)
#  worker_responsability :string(255)
#  operational_status    :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  workstation_id        :integer
#  worker_profile_id     :integer
#  event_type            :string(255)
#

require 'spec_helper'

RSpec.describe Events::Log do
  pending "add some examples to (or delete) #{__FILE__}"
end
