Amazon::Ecs.configure do |options|
  c = Rails.application.secrets
  options[:AWS_access_key_id] = ENV["AWS_ACCESS_KEY_ID"] || c.aws_access_key_id
  options[:AWS_secret_key] = ENV["AWS_SECRET_KEY"] || c.aws_secret_key
  options[:associate_tag] = ENV["ASSOCIATE_TAG"] || c.associate_tag
  options[:country] = :jp
end

Amazon::Ecs::debug = true if Rails.env.development?
