# == Schema Information
#
# Table name: accounts
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  surname          :string(255)
#  email            :string(255)
#  crypted_password :string(255)
#  role             :string(255)
#  active           :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

RSpec.describe Account do
  pending "add some examples to (or delete) #{__FILE__}"
end
