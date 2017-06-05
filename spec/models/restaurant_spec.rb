require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "scopes" do
    describe ".search" do
      let!(:restaurant_1) { Restaurant.create(name: 'Churrascaria Tropeiro') }
      let!(:restaurant_2) { Restaurant.create(name: 'Churrascaria Chimarrão') }
      let!(:restaurant_3) { Restaurant.create(name: 'Bar e Restaurante Liro Chef') }
      let!(:restaurant_4) { Restaurant.create(name: 'Barolo Ristorante') }

      context "without parameter" do
        subject { Restaurant.search }
        it { is_expected.to eq Restaurant.all }
      end

      context "with parameter" do
        context "and match name" do
          subject(:restaurants) { Restaurant.search('Churrascaria') }
          it { expect(restaurants.count).to eq 2 }
          it { is_expected.to include restaurant_1 }
          it { is_expected.to include restaurant_2 }
        end

        it "case insentivive search" do
          expect(Restaurant.search('churrascaria').map(&:id)).to eq Restaurant.search('CHURRASCARIA').map(&:id)
        end
      end
    end
  end
end
