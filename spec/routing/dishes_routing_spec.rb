require "rails_helper"

RSpec.describe DishesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/api/dishes").to route_to("dishes#index")
    end


    it "routes to #show" do
      expect(:get => "/api/dishes/1").to route_to("dishes#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/api/dishes").to route_to("dishes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/api/dishes/1").to route_to("dishes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/api/dishes/1").to route_to("dishes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/api/dishes/1").to route_to("dishes#destroy", :id => "1")
    end

  end
end
