# coding: utf-8
require 'rails_helper'

RSpec.describe "Kindles", type: :request do
  include Committee::Rails::Test::Methods

  before :each do
    create :kindle
  end

  let(:headers) do
    { 'ACCEPT': 'application/json' }
  end

  describe "GET /kindles" do
    it "利用できない。存在しないリソース扱い" do
      get kindles_path, headers: headers
      expect(response.content_type).to eq("application/json")
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /kindles/{kindle_id}" do
    context "データが存在する場合" do
      it "Status code 200を返す" do
        get kindle_path(id: "B01N3PNATY"), headers: headers
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(200)
      end

      it "仕様通りのjsonデータを返す" do
        get kindle_path(id: "B01N3PNATY"), headers: headers
        expect(response.content_type).to eq("application/json")
        assert_schema_conform
      end
    end

    context "データが存在しない場合" do
      it "Status code 404を返す" do
        get kindle_path(id: "0000000000"), headers: headers
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(404)
        assert_schema_conform
      end
    end
  end
end
