# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  pub_id           :string(255)
#  name             :string(255)
#  first_name       :string(255)
#  email            :string(255)
#  crypted_password :string(255)
#  active           :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#  role_id          :integer
#

class User < ActiveRecord::Base
  include PublicIdentifier

  attr_accessor :password, :password_confirmation

  # Associations
  belongs_to :role, required: true
  has_many :worker_profiles

  # Validations
  validates_presence_of     :email
  validates_presence_of     :password,                   :if => :password_required
  validates_presence_of     :password_confirmation,      :if => :password_required
  validates_length_of       :password, :within => 4..40, :if => :password_required
  validates_confirmation_of :password,                   :if => :password_required
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  # Callbacks
  before_save :encrypt_password, :if => :password_required

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    user = where("lower(email) = lower(?)", email).first if email.present?
    (user && user.active? && user.has_password?(password)) ? user : nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(crypted_password) == password
  end

  def active?
    active
  end

  # These functions check whether a user can perform an action.
  # Some actions are performed on entities like worker_profile or shift
  # For example, "see the schedule" or "conduct a SAFAPS assesement"
  # implies a worker profile. Yet, "prepare_shift_schedule" implies a shift .
  def is_authorized_to_perform(action)
    permission = role.shift_management_permissions_table.read_attribute(:"#{action}")
    return permission != :nobody
  end

  def is_authorized_to_perform_on_worker_profile(action, worker_profile)
    permission = role.shift_management_permissions_table.read_attribute(:"#{action}")
    if (permission == "nobody") then
      return false
    end
    #Padrino::Logger.logger.add(:debug, permission)
    if (permission == "self") then
      return worker_profiles.where(:id => worker_profile.id).exists?
    end


    if (permission == "shift") then
      worker_profiles.each do |wp|
        # Get the shift that have not finished
        current_shifts = wp.shifts.where("end > ?", Time.now)
        current_shifts.each do |shift|
          if (shift.worker_profiles.where(:id => worker_profile.id).exists?) then
            return true
          end
        end
      end

      return false
    end

    return false
  end

  def is_authorized_to_perform_on_shift(action, shift)
    permission = role.shift_management_permissions_table.read_attribute(:"#{action}")
    if (permission == "nobody") then
      return false
    end

    if (permission == "self") then
      return false
    end
    
    if (permission == "shift") then
      worker_profiles.each do |worker_profile|
        # Get the shift that have not finished
        return worker_profile.shifts.where(:id => shift.id).exists?
      end

      return false
    end

    return false
  end

  private

  def encrypt_password
    value = ::BCrypt::Password.create(password)
    value = value.force_encoding(Encoding::UTF_8) if value.encoding == Encoding::ASCII_8BIT
    self.crypted_password = value
  end

  def password_required
    crypted_password.blank? || password.present?
  end
end
