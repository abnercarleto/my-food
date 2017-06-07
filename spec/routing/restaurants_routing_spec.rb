require "rails_helper"

RSpec.describe RestaurantsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/restaurants").to route_to("restaurants#index")
    end


    it "routes to #show" do
      expect(:get => "/api/restaurants/1").to route_to("restaurants#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/restaurants").to route_to("restaurants#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/restaurants/1").to route_to("restaurants#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/restaurants/1").to route_to("restaurants#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/restaurants/1").to route_to("restaurants#destroy", :id => "1")
    end

  end
end
