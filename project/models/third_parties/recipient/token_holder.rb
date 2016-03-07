class ThirdParties::Recipient
  class TokenHolder < ActiveRecord::Base
    # Associations
    belongs_to :organization,
      class_name: ThirdParties::Recipient::Organization,
      required: true
    belongs_to :tokenable_r,
      polymorphic: true

    # Validation
    validates_presence_of :name
    validates_presence_of :token

    # Callbacks
  end
end
