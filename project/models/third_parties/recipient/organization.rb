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
