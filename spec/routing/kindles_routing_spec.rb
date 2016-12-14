require "rails_helper"

RSpec.describe KindlesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/kindles").to route_to("kindles#index")
    end

    it "routes to #new" do
      expect(:get => "/kindles/new").to route_to("kindles#new")
    end

    it "routes to #show" do
      expect(:get => "/kindles/1").to route_to("kindles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/kindles/1/edit").to route_to("kindles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/kindles").to route_to("kindles#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/kindles/1").to route_to("kindles#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/kindles/1").to route_to("kindles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/kindles/1").to route_to("kindles#destroy", :id => "1")
    end

  end
end
