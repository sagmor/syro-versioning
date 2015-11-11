require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

require 'rack/test'
RSpec.configure { |c| c.include Rack::Test::Methods }

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'syro/versioning'
