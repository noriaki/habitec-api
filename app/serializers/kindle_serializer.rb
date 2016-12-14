class KindleSerializer < ActiveModel::Serializer
  attributes :id, :asin, :title, :publisher, :authors, :image_url, :publish_at
end
