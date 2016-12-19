class KindleSerializer < ActiveModel::Serializer
  attribute :asin, key: :id
  attributes :title, :publisher, :authors, :images, :published_at, :created_at, :updated_at, :url
end
