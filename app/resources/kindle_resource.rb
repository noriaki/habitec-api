class KindleResource
  @@ttl = 24.hours
  @@default_no_image_url = 'https://images-fe.ssl-images-amazon.com/images/G/09/nav2/dp/no-image-no-ciu.gif'

  class RequestError < StandardError
    def initialize(code, message)
      @code = code
      super "[#{code}] - #{message}"
    end
  end

  def initialize(kindle_instance)
    @asin = kindle_instance.asin
    @incomplete = kindle_instance.incomplete?
    @updated_at = kindle_instance.updated_at.presence || Time.zone.local(1999)
    @response = nil
  end

  def fetch!
    if @incomplete || expired?
      @response = Amazon::Ecs.item_lookup(
        @asin, response_group: "Images,ItemAttributes")
      error = @response.get_element('Errors/Error')
      if @response.first_item.nil? && error.present?
        raise RequestError.new error.get('Code'), error.get('Message')
      end
    end
    self
  end

  def to_param
    item = @response.first_item
    {
      asin: @asin,
      title: item.get('ItemAttributes/Title'),
      publisher: item.get('ItemAttributes/Publisher'),
      authors: item.get_array('ItemAttributes/Author'),
      image_url: item.get("ImageSets/ImageSet[@Category='primary']/LargeImage/URL").presence || @@default_no_image_url,
      published_at: item.get('ItemAttributes/PublicationDate'),
    }
  end

  private
  def expired?
    @@ttl < Time.zone.now - @updated_at
  end
end
