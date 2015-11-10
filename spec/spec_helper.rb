$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'syro/versioning'

require 'rack/test'
RSpec.configure { |c| c.include Rack::Test::Methods }

