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

class ThirdParties::Recipient::Organization < ActiveRecord::Base
  # Associations
  belongs_to :recipient,
    class_name: ThirdParties::Recipient,
    required: true
  has_many :token_holders,
    class_name: ThirdParties::Recipient::TokenHolder

  # Validation
  validates_presence_of :name

  # Callbacks
end
