class Restaurant < ApplicationRecord
  has_many :dishes

  validates :name, presence: true

  scope :search, -> (partial_name = nil) { partial_name.blank? ? all : where('name like ?', "%#{partial_name}%") }
end
