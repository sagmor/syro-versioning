# Syro::Versioning

[![Gem](https://img.shields.io/gem/v/syro-versioning.svg)](https://rubygems.org/gems/syro-versioning)
[![Build Status](https://travis-ci.org/sagmor/syro-versioning.svg)](https://travis-ci.org/sagmor/syro-versioning)
[![Test Coverage](https://codeclimate.com/github/sagmor/syro-versioning/badges/coverage.svg)](https://codeclimate.com/github/sagmor/syro-versioning/coverage)
[![Code Climate](https://codeclimate.com/github/sagmor/syro-versioning/badges/gpa.svg)](https://codeclimate.com/github/sagmor/syro-versioning)
[![Inline docs](http://inch-ci.org/github/sagmor/syro-versioning.svg?branch=master)](http://inch-ci.org/github/sagmor/syro-versioning)


Add versioning matchers to your `Syro::Deck`

## Usage

Add this line to your application's Gemfile:

```ruby
gem 'syro-versioning'
```

Include it in your `Syro::Deck`

```ruby
require "syro/versioning"

class MyApp < Syro::Deck
  include Syro::Versioning
end
```

Add versions to your app:

```ruby
app = Syro.new(MyApp) {
  version(20151110) {
    get {
      res.write "Version 3"
    }
  }

  version(20150102) {
    get {
      res.write "Version 2"
    }
  }

  version(20150101) {
    get {
      res.write "Version 1"
    }
  }
}

env = {
  "REQUEST_METHOD" => "GET",
  "PATH_INFO"      => "/"
}

p app.call(env)
#=> [200, {"Content-Length"=>"13", "Content-Type"=>"text/html"}, ["Version 3"]]

p app.call(env.merge('HTTP_ACCEPT' => 'text/html; version=20150701'))
#=> [200, {"Content-Length"=>"13", "Content-Type"=>"text/html"}, ["Version 2"]]

p app.call(env.merge('HTTP_ACCEPT' => 'text/html; version=20150101'))
#=> [200, {"Content-Length"=>"13", "Content-Type"=>"text/html"}, ["Version 1"]]

p app.call(env.merge('HTTP_ACCEPT' => 'text/html; version=20140101'))
#=> [404, {}, []]
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/syro-versioning. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

