require "syro"

require "syro/versioning/version"

class Syro
  module Versioning

    def version(number,&block)
      return if number > request_version
      instance_eval(&block)
    end

    def request_version
      @request_version ||= if match = /version=(\d+)/.match(req.env['HTTP_ACCEPT'])
        match[1].to_i
      else
        now = Time.now
        now.day + 100*now.month + 10000*now.year
      end
    end

  end
end
