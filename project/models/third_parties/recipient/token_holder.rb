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
    before_validation :generate_token, on: :create

    private

    def generate_token
      self.token = loop do
        s = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
        break s unless self.class.exists?(token: s)
      end
    end
  end
end
