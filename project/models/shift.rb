class Shift < ActiveRecord::Base
  # Associations
  belongs_to :facility, required: true
  has_and_belongs_to_many :worker_profiles

  # Validations
  validates_presence_of   :begin
  validates_presence_of   :end

  # Callbacks
end
