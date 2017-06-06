require 'rails_helper'

RSpec.describe "Dishes", type: :request do
  let(:restaurant) { Restaurant.create!(name: 'My Restaurant') }

  let(:valid_attributes) {
    {
      restaurant_id: restaurant.id,
      name: 'BBQ Ribs',
      price: '33.90'
    }
  }

  let(:invalid_attributes) {
    {
      restaurant_id: nil,
      name: 'BBQ Ribs',
      price: '33.90'
    }
  }

  describe "GET #index" do
    it "returns a success response" do
      dish = Dish.create! valid_attributes
      get dishes_path
      expect(response).to be_success
      expect(response.body).to eq Dish.all.to_json
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      dish = Dish.create! valid_attributes
      get dish_path(dish)
      expect(response).to be_success
      expect(response.body).to eq dish.to_json
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Dish" do
        expect {
          post dishes_path, params: {dish: valid_attributes}
        }.to change(Dish, :count).by(1)
      end

      it "renders a JSON response with the new dish" do

        post dishes_path, params: {dish: valid_attributes}
        expect(response).to have_http_status(:created)
        expect(response.body).to eq Dish.last.to_json
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new dish" do

        post dishes_path, params: {dish: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq Dish.create(invalid_attributes).errors.to_json
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'Roasted BBQ Turkey Legs'
        }
      }

      it "updates the requested dish" do
        dish = Dish.create! valid_attributes
        expect {
          put dish_path(dish), params: {dish: new_attributes}
          dish.reload
        }.to change { dish.name }.to('Roasted BBQ Turkey Legs')
      end

      it "renders a JSON response with the dish" do
        dish = Dish.create! valid_attributes

        put dish_path(dish), params: {dish: new_attributes}
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq JSON.parse(dish.reload.to_json)
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the dish" do
        dish = Dish.create! valid_attributes

        put dish_path(dish), params: {dish: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq dish.tap { |d| d.attributes = invalid_attributes }.tap { |d| d.valid? }.errors.to_json
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested dish" do
      dish = Dish.create! valid_attributes
      expect {
        delete dish_path(dish)
      }.to change(Dish, :count).by(-1)
    end
  end
end
