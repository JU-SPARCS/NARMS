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

require 'spec_helper'

RSpec.describe Role do
  pending "add some examples to (or delete) #{__FILE__}"
end
