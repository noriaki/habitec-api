require "rails_helper"

RSpec.describe KindlesController, type: :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/kindles/B01N3PNATY").to route_to("kindles#show", :id => "B01N3PNATY")
    end

    it "routes to #create" do
      expect(:post => "/kindles").to route_to("kindles#create")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/kindles/B01N3PNATY").to route_to("kindles#update", :id => "B01N3PNATY")
    end

  end
end
