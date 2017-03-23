class User < ActiveRecord::Base
  attr_accessor :password_confirmation
  has_many :events
  has_many :events, :through => :attendees
  has_many :attendees

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :state, :password, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum:8 }
  validate :password_matcher, on: :create

  protected
    def password_matcher
      if self.password != self.password_confirmation
        errors.add(:password_confirmation, "Passwords do not match!")
      end
    end
end
