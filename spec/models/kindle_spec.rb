# coding: utf-8
require 'rails_helper'

RSpec.describe Kindle, type: :model do
  describe "fields" do
    it :asin do
      is_expected.to have_fields(:asin).of_type(String)
      is_expected.to validate_presence_of(:asin)
      is_expected.to validate_uniqueness_of(:asin)
      is_expected.to validate_length_of(:asin).is(10)
      is_expected.to validate_format_of(:asin)
                      .to_allow("B01N3PNATY").not_to_allow("a-1")
      is_expected.to have_index_for(asin: 1)
                      .with_options(unique: true, background: true)
    end

    it :title do
      is_expected.to have_fields(:title).of_type(String)
      is_expected.to have_index_for(title: 1)
                      .with_options(background: true)
    end

    it :publisher do
      is_expected.to have_fields(:publisher).of_type(String)
      is_expected.to have_index_for(publisher: 1)
                      .with_options(background: true)
    end

    it :authors do
      is_expected.to have_fields(:authors).of_type(Array)
      is_expected.to have_index_for(authors: 1)
                      .with_options(background: true)
    end

    it :image_url do
      is_expected.to have_fields(:image_url).of_type(String)
    end

    it :published_at do
      is_expected.to have_fields(:published_at).of_type(Date)
      is_expected.to have_index_for(published_at: -1)
                      .with_options(background: true)
    end

    it :timestamps do
      is_expected.to be_timestamped_document
    end
  end

  describe "#images" do
    subject { build(:kindle).images }

    it "return Hash" do
      expect(subject).to be_a(Hash)
    end

    it "returning have keys: :swatch, :small, :tiny, :medium, :large" do
      expect(subject).to have_key(:swatch)
      expect(subject).to have_key(:small)
      expect(subject).to have_key(:tiny)
      expect(subject).to have_key(:medium)
      expect(subject).to have_key(:large)
    end

    describe "values match URI pattern" do
      let(:base_pattern) do
        Regexp.new(
          "^https://images-fe\.ssl-images-amazon\.com/images/.*?\.(gif|jpg)$")
      end

      it ":swatch" do
        expect(subject[:swatch]).to match(base_pattern)
        expect(subject[:swatch]).to match(Regexp.new "\._SL30_\.(gif|jpg)$")
      end

      it ":small" do
        expect(subject[:small]).to match(base_pattern)
        expect(subject[:small]).to match(Regexp.new "\._SL75_\.(gif|jpg)$")
      end

      it ":tiny" do
        expect(subject[:tiny]).to match(base_pattern)
        expect(subject[:tiny]).to match(Regexp.new "\._SL110_\.(gif|jpg)$")
      end

      it ":medium" do
        expect(subject[:medium]).to match(base_pattern)
        expect(subject[:medium]).to match("\._SL160_\.(gif|jpg)$")
      end

      it ":large" do
        expect(subject[:large]).to match(base_pattern)
      end
    end

    context "case: image_url field is nil" do
      subject { build(:kindle, image_url: nil).images }

      it "return nil" do
        expect(subject).to be_nil
      end
    end
  end

  describe "#url" do
    subject { build :kindle }

    it "composed of BASE_URI and ASIN, Associate ID" do
      base_uri = "https://www.amazon.co.jp/o/ASIN"
      associate_tag = "habitec-22"
      expect(subject.url).to eq("#{base_uri}/#{subject.asin}/#{associate_tag}")
    end
  end

  describe "#incomplete?" do
    context "all attrs fill (except :image_url)" do
      subject { build :kindle }

      it "return false" do
        expect(subject.incomplete?).to be false
        subject.image_url = nil
        expect(subject.incomplete?).to be false
      end
    end

    context "any attr blank (except :image_url)" do
      subject { Kindle.new }
      let(:attrs) { attributes_for :kindle }

      it "return true" do
        subject.asin = attrs[:asin]
        expect(subject.incomplete?).to be true
        subject.image_url = attrs[:image_url]
        expect(subject.incomplete?).to be true
        subject.title = attrs[:title]
        expect(subject.incomplete?).to be true
        subject.publisher = attrs[:publisher]
        expect(subject.incomplete?).to be true
        subject.authors = attrs[:authors]
        expect(subject.incomplete?).to be true
        subject.published_at = attrs[:published_at]
        expect(subject.incomplete?).to be false
      end
    end
  end
end
