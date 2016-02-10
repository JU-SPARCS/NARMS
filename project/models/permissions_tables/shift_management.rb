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
#

class PermissionsTables::ShiftManagement < ActiveRecord::Base
  extend  Enumerize
  include PermissionsTables

  enumerize :conduct_safaps_assessment,          :in => PERMISSIONS_LEVELS
  enumerize :prepare_shift_schedule,             :in => PERMISSIONS_LEVELS
  enumerize :view_atco_safaps_shift_inputs,      :in => PERMISSIONS_LEVELS
  enumerize :view_atco_safaps_shift_assessments, :in => PERMISSIONS_LEVELS
  enumerize :manage_atco_safaps_categories,      :in => PERMISSIONS_LEVELS
end
