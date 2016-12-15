# coding: utf-8
require 'rails_helper'

RSpec.describe "Kindles", type: :request do
  include Committee::Rails::Test::Methods

  before :each do
    create :kindle
  end

  describe "GET /kindles" do
    it "利用できない。存在しないリソース扱い" do
      get kindles_path
      expect(response).to have_http_status(404)
    end
  end

  describe "GET /kindles/{kindle_id}" do
    context "データが存在する場合" do
      it "Status code 200を返す" do
        get kindle_path(id: "B01N3PNATY")
        expect(response).to have_http_status(200)
        assert_schema_conform
      end

      it "仕様通りのjsonデータを返す" do
        get kindle_path(id: "B01N3PNATY")
        assert_schema_conform
      end
    end

    context "データが存在しない場合" do
      it "Status code 404を返す" do
        get kindle_path(id: "0000000000")
        expect(response).to have_http_status(404)
        assert_schema_conform
      end
    end
  end
end
