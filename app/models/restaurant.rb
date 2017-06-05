class Restaurant < ApplicationRecord
  validates :name, presence: true

  scope :search, -> (partial_name = nil) { partial_name.blank? ? all : where('name like ?', "%#{partial_name}%") }
end
