# == Schema Information
#
# Table name: schedule_slots_workers
#
#  id                  :integer          not null, primary key
#  begin_at            :datetime
#  end_at              :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  schedules_worker_id :integer
#

require 'spec_helper'

RSpec.describe ScheduleSlots::Worker do
  pending "add some examples to (or delete) #{__FILE__}"
end
