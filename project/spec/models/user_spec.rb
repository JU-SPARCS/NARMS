# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  pub_id           :string(255)
#  name             :string(255)
#  first_name       :string(255)
#  email            :string(255)
#  crypted_password :string(255)
#  active           :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

RSpec.describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
