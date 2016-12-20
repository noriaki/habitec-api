# coding: utf-8
require 'rails_helper'

RSpec.describe "Kindles", type: :request do
  include Committee::Rails::Test::Methods

  let(:headers) do
    { 'ACCEPT': 'application/json', 'Content-Type': 'application/json' }
  end

  describe "GET" do
    before :each do
      create :kindle
    end

    describe "/kindles" do
      it "利用できない。存在しないリソース扱い" do
        get kindles_path, headers: headers
        expect(response.content_type).to eq("application/json")
        expect(response).to have_http_status(404)
      end
    end

    describe "/kindles/{kindle_id}" do
      context "データが存在する場合" do
        it "Status code 200を返す" do
          get kindle_path(id: attributes_for(:kindle)[:asin]), headers: headers
          expect(response.content_type).to eq("application/json")
          expect(response).to have_http_status(200)
        end

        it "仕様通りのjsonデータを返す" do
          get kindle_path(id: attributes_for(:kindle)[:asin]), headers: headers
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

  describe "POST" do
    describe "/kindles" do
      context "新規ASINの場合" do
        it "登録に成功し:201を返す" do
          expect {
            post(kindles_path,
                 params: { id: attributes_for(:kindle)[:asin] }.to_json,
                 headers: headers)
          }.to change(Kindle, :count).by(1)
          expect(response.content_type).to eq("application/json")
          expect(response).to have_http_status(:created)
          assert_schema_conform
        end
      end

      context "既存ASINの場合" do
        let!(:entity) { create :kindle }

        it "登録に失敗し:422を返す" do
          expect {
            post(kindles_path,
                 params: { id: attributes_for(:kindle)[:asin] }.to_json,
                 headers: headers)
          }.to change(Kindle, :count).by(0)
          expect(response.content_type).to eq("application/json")
          expect(response).to have_http_status(:unprocessable_entity)
          assert_schema_conform
        end
      end

      context "必須パラメータ:id (:asin)が存在しない場合" do
        it "エラーとなり:400を返す" do
          expect {
            post(kindles_path, headers: headers)
          }.to change(Kindle, :count).by(0)
          expect(response.content_type).to eq("application/json")
          expect(response).to have_http_status(:bad_request)
          assert_schema_conform
        end
      end
    end
  end

  describe "PATCH" do
    describe "/kindles/{kindle_id}" do
      subject { Kindle.create(asin: attributes_for(:kindle)[:asin]) }

      context "未登録ASINの場合" do
        it ":404を返す" do
          patch kindle_path(id: "0" * 10), headers: headers

          expect(response.content_type).to eq("application/json")
          expect(response).to have_http_status(:not_found)
        end
      end

      context "登録済みASINで" do
        context "有効なASINの場合" do
          it "最新データに更新され:200とデータを返す" do
            patch kindle_path(id: subject.asin), headers: headers

            expect(response.content_type).to eq("application/json")
            expect(response).to have_http_status(:success)
            assert_schema_conform

            expect(subject.reload.title).to_not be_nil
            expect(subject.reload.authors).to_not be_nil
            expect(subject.reload.publisher).to_not be_nil
            expect(subject.reload.image_url).to_not be_nil
            expect(subject.reload.published_at).to_not be_nil
          end
        end

        context "無効なASINの場合" do
          subject { Kindle.create asin: "B00JUUB1UE" }

          it ":422とAmazon Product Advertise APIのエラーを返す" do
            patch kindle_path(id: subject.asin), headers: headers

            expect(response.content_type).to eq("application/json")
            expect(response).to have_http_status(:unprocessable_entity)

            expect(subject.reload.title).to be_nil
          end
        end
      end
    end
  end
end
