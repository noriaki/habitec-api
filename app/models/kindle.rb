class Kindle
  include Mongoid::Document
  include Mongoid::Timestamps

  field :asin, type: String
  field :title, type: String
  field :publisher, type: String
  field :authors, type: Array
  field :image_url, type: String
  field :published_at, type: Date

  index({ asin: 1 }, { unique: true, background: true })
  index({ title: 1 }, { background: true })
  index({ publisher: 1 }, { background: true })
  index({ authors: 1 }, { background: true })
  index({ published_at: -1 }, { background: true })

  validates_presence_of :asin
  validates_uniqueness_of :asin
  validates_length_of :asin, is: 10
  validates_format_of :asin, with: /\A[0-9A-Z]{10}\z/

  def images
    image_url.nil? ? nil : {
      swatch: build_image_url(:swatch),
      small: build_image_url(:small),
      tiny: build_image_url(:tiny),
      medium: build_image_url(:medium),
      large: build_image_url(:large)
    }
  end

  def url
    base_uri = "https://www.amazon.co.jp/o/ASIN"
    associate_tag = ENV.fetch("ASSOCIATE_TAG")
    [ base_uri, asin, associate_tag ].join("/")
  end

  def fetch
    resource = KindleResource.new self
    resource.fetch!
    resource.to_param
  rescue => e#KindleResource::RequestError => e
    errors[:base] << e.message
    false
  end

  def incomplete?
    %w(title publisher authors published_at).any? {|f| self[f.to_sym].blank? }
  end

  private
  def build_image_url(label)
    labels = {
      swatch: "._SL30_", small: "._SL75_",
      tiny: "._SL110_", medium: "._SL160_"
    }
    image_path = Pathname(image_url)
    image_path.sub_ext(labels[label.to_sym].to_s + image_path.extname).to_s
  end
end
