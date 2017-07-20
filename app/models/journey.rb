class Journey < ApplicationRecord
  has_many :meetings

  validates :name, presence: true
  validates :start_time, presence: true
end
