class ThirdParties::Recipient < ActiveRecord::Base
  # Associations
  has_many :organizations,
    class_name: ThirdParties::Recipient::Organization,
    dependent: :destroy

  # Validation
  validates_presence_of :name

  # Callbacks
end
