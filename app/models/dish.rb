class Dish < ApplicationRecord
  belongs_to :restaurant

  validates :name, :price, :restaurant, presence: true
end
