require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  let(:valid_attributes) {
    { name: "My Restaurant" }
  }

  let(:invalid_attributes) {
    { name: nil }
  }

  describe "GET /restaurants" do
    let!(:restaurant_1) { Restaurant.create(name: 'Churrascaria Tropeiro') }
    let!(:restaurant_2) { Restaurant.create(name: 'Churrascaria Chimarrão') }
    let!(:restaurant_3) { Restaurant.create(name: 'Bar e Restaurante Liro Chef') }
    let!(:restaurant_4) { Restaurant.create(name: 'Barolo Ristorante') }

    it "resturns a json with all restaurants" do
      get restaurants_path
      expect(response).to have_http_status(200)
      expect(response.body).to eq Restaurant.all.to_json
    end

    it "resturns a json that matches a query" do
      get restaurants_path(q: 'churrascaria')
      expect(response).to have_http_status(200)
      expect(response.body).to eq Restaurant.search('churrascaria').to_json
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      restaurant = Restaurant.create! valid_attributes
      get restaurant_path(restaurant)
      expect(response).to be_success
      expect(response.body).to eq restaurant.to_json
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Restaurant" do
        expect {
          post restaurants_path, params: {restaurant: valid_attributes}
        }.to change(Restaurant, :count).by(1)
      end

      it "renders a JSON response with the new restaurant" do

        post restaurants_path, params: {restaurant: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.body).to eq Restaurant.last.to_json
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new restaurant" do

        post restaurants_path, params: {restaurant: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq Restaurant.create(invalid_attributes).errors.to_json
      end
    end
  end

  describe "PATCH #update" do
    context "with valid params" do
      let(:new_attributes) {
        { name: 'Other Restaurant' }
      }

      it "updates the requested restaurant" do
        restaurant = Restaurant.create! valid_attributes
        expect {
          patch restaurant_path(restaurant), params: {restaurant: new_attributes}
          restaurant.reload
        }.to change { restaurant.name }.to('Other Restaurant')
      end

      it "renders a JSON response with the restaurant" do
        restaurant = Restaurant.create! valid_attributes

        patch restaurant_path(restaurant), params: {restaurant: new_attributes}
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq restaurant.reload.to_json
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the restaurant" do
        restaurant = Restaurant.create! valid_attributes

        patch restaurant_path(restaurant), params: {restaurant: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq restaurant.tap { |r| r.attributes = invalid_attributes }.tap { |r| r.valid? }.errors.to_json
      end
    end
  end
end
