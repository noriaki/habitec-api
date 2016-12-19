require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
# require "action_mailer/railtie"
require "action_view/railtie"
# require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module HabitecApi
  class Application < Rails::Application
    config.time_zone = 'Tokyo'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    # JSON Schema
    JSON.parse(File.read(Rails.root.join("docs/schema/schema.json"))).tap {|schema|
      config.middleware.use Committee::Middleware::RequestValidation,
                            schema: schema, strict: true
      config.middleware.use Committee::Middleware::ResponseValidation,
                            schema: schema
      #config.middleware.insert_before(
      #  ActionDispatch::Executor,
      #  Committee::Middleware::RequestValidation,
      #  schema: schema, strict: true
      #)
      #config.middleware.insert_before(
      #  ActionDispatch::Executor,
      #  Committee::Middleware::ResponseValidation,
      #  schema: schema
      #)
      # config.middleware.use Committee::Middleware::Stub, schema: schema
    }
  end
end
