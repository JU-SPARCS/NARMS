# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  active     :boolean          default(TRUE)
#  created_at :datetime
#  updated_at :datetime
#

class Role < ActiveRecord::Base

  # Associations
  has_many :users
  has_one :shift_management_permissions_table, class_name: PermissionsTables::ShiftManagement, dependent: :destroy

  # Validation
  validates_presence_of :name

  # Callbacks
  after_save :create_shift_management_permissions_table_if_missing

  private

  def method_missing(meth, *args, &blk)
    reg = /(.+)_if_missing$/
    reg.match(meth) { |m| return send(m.captures.first, *args, &blk) }
    super
  end
end
