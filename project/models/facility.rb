# == Schema Information
#
# Table name: facilities
#
#  id         :integer          not null, primary key
#  pub_id     :string(255)
#  active     :boolean          default(TRUE)
#  name       :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# TOFIX: no need for a 1-n assossiation for the tokens?
class Facility < ActiveRecord::Base
  include PublicIdentifier

  # Associations
  has_many :worker_profiles, dependent: :destroy
  has_many :workstations, dependent: :destroy
  has_many :shifts, dependent: :destroy
  has_many :airspace_segments, dependent: :destroy
  has_many :tokens,
    class_name: ThirdParties::Recipient::TokenHolder,
    as: :tokenable_r

  # Validations
  # Callbacks

  def has_matching_token?(token)
    !!tokens.find_by_token(token)
  end
end
