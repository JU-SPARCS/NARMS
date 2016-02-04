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
#

class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

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
  before_create :generate_pub_id

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

  private

  def encrypt_password
    value = ::BCrypt::Password.create(password)
    value = value.force_encoding(Encoding::UTF_8) if value.encoding == Encoding::ASCII_8BIT
    self.crypted_password = value
  end

  def password_required
    crypted_password.blank? || password.present?
  end

  def generate_pub_id
    self.pub_id = loop do
      s = Digest::SHA1.hexdigest([Time.now, rand].join)[0..10]
      break s unless self.class.exists?(pub_id: s)
    end
  end
end
