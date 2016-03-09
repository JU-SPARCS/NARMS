# == Schema Information
#
# Table name: third_parties_recipients
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class ThirdParties::Recipient < ActiveRecord::Base
  # Associations
  has_many :organizations,
    class_name: ThirdParties::Recipient::Organization,
    dependent: :destroy

  # Validation
  validates_presence_of :name

  # Callbacks
end
