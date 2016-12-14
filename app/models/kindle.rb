class Kindle
  include Mongoid::Document
  include Mongoid::Timestamps
  field :asin, type: String
  field :title, type: String
  field :publisher, type: String
  field :authors, type: Array
  field :image_url, type: String
  field :publish_at, type: Date
end
