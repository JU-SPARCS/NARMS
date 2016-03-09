# == Schema Information
#
# Table name: third_parties_recipients_token_holders
#
#  id               :integer          not null, primary key
#  name             :string(255)
#  token            :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  organization_id  :integer
#  tokenable_r_id   :integer
#  tokenable_r_type :string(255)
#

require 'spec_helper'

RSpec.describe ThirdParties::Recipient::TokenHolder do
  pending "add some examples to (or delete) #{__FILE__}"
end
