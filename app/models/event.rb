class Event < ActiveRecord::Base
  belongs_to :host, class_name: 'User', foreign_key: 'host_id'
  has_many :attendees
  has_many :users, through: :attendees
  has_many :comments
  validates :name, :date, :city, :state, presence: true
  validates :state, length: { is:2 }
  validate :cannot_be_before

  def cannot_be_before
    if date.present? && date < Date.today
      errors.add(:date, "cannot be in the past.")
    end
  end

end
