# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
ActiveRecord::Migration.maintain_test_schema!

BASE64_IMG_REGEX = /data:(image\/gif|image\/jpeg|image\/png);base64,([a-zA-Z0-9+\/]+)=/i

IMG2MIME = {
    :gif => 'image/gif',
    :jpeg => 'image/jpeg',
    :png => 'image/png',
    :jpg => 'image/jpg',
    :pdf => 'application/pdf'
}

def file2base64(file_path)
  img_type = file_path.split('.').last.to_sym
  f = File.open(file_path, 'r')
  base64_content = Base64.strict_encode64(f.read)
  "data:#{IMG2MIME[img_type]};base64,#{base64_content}="
end

class Integer
  N_BYTES = [42].pack('i').size
  N_BITS = N_BYTES * 16
  MAX = 2 ** (N_BITS - 2) - 1
  MIN = -MAX - 1
end

def gen_id(*excluding)
  rnd = Random.new
  id = rnd.rand(Integer::MAX)
  (id = rnd.rand(Integer::MAX)) unless excluding.exclude?(id)
  id
end

RSpec.configure do |config|
  config.full_backtrace = true
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

end
