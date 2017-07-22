class Journey < ApplicationRecord
  has_many :meetings, inverse_of: :journey, dependent: :destroy
  # validates_presence_of :meetings
  validates :name, presence: true
  validates :start_time, presence: true
  validates :start_date, presence: true

  accepts_nested_attributes_for :meetings, reject_if: :all_blank, allow_destroy: true
end
