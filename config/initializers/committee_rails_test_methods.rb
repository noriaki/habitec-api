module Committee::Rails
  module Test
    module Methods
      extend ActiveSupport::Concern

      include Committee::Test::Methods

      def schema_path
        Rails.root.join('docs', 'schema', 'schema.json')
      end

      def last_request; request; end
      def last_response; response; end
    end
  end
end
