require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "associations" do
    it { is_expected.to belong_to :restaurant }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:restaurant) }
  end
end
