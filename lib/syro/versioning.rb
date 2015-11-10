require "syro"

require "syro/versioning/version"

class Syro # :nodoc:

  # Include on `Syro::Deck` to enable API versioning
  module Versioning

    # Describe a version block inside a Syro app.
    #
    # @param number [Integer] The minimum version number to match.
    # @param block The route to process if version matches.
    # @returns [void]
    #
    # @example
    #     Syro.new(AppDeck) {
    #       version(20150101) {
    #         get {
    #           res.write "Version 2015-01-01"
    #         }
    #       }
    #       version(1) {
    #         get {
    #           res.write "Version 1"
    #         }
    #       }
    #     }
    #
    def version(number,&block)
      return if number > request_version
      instance_eval(&block)
    end

    # Fetch the version for the current request's Accept header
    #
    # @returns [Integer] The matched version number
    #
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
