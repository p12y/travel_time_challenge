class Journey < ApplicationRecord
  has_many :meetings

  validates :name, presence: true
  validates :start_time, presence: true

  accepts_nested_attributes_for :meeting, reject_if: :all_blank, allow_destroy: true
end
