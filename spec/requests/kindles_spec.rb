require 'rails_helper'

RSpec.describe "Kindles", type: :request do
  describe "GET /kindles" do
    it "works! (now write some real specs)" do
      get kindles_path
      expect(response).to have_http_status(200)
    end
  end
end
