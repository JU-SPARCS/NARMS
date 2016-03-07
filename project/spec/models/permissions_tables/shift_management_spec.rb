# == Schema Information
#
# Table name: permissions_tables_shift_managements
#
#  id                                 :integer          not null, primary key
#  conduct_safaps_assessment          :string(255)      default("nobody")
#  prepare_shift_schedule             :string(255)      default("nobody")
#  view_atco_safaps_shift_inputs      :string(255)      default("nobody")
#  view_atco_safaps_shift_assessments :string(255)      default("nobody")
#  manage_atco_safaps_categories      :string(255)      default("nobody")
#  created_at                         :datetime
#  updated_at                         :datetime
#  role_id                            :integer
#  view_atco_worker_schedule          :string(255)
#  view_atco_worker_log_event         :string(255)
#

require 'spec_helper'

RSpec.describe PermissionsTables::ShiftManagement do
  pending "add some examples to (or delete) #{__FILE__}"
end
