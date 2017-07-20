class Meeting < ApplicationRecord
  belongs_to :journey

  validates :postcode, presence: true
  validates :duration, presence: true
  validates :name, presence: true
end
