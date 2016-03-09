# == Schema Information
#
# Table name: third_parties_recipients_organizations
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  recipient_id :integer
#

require 'spec_helper'

RSpec.describe ThirdParties::Recipient::Organization do
  pending "add some examples to (or delete) #{__FILE__}"
end
