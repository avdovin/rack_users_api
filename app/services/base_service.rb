# frozen_string_literal: true

require 'dry/monads/result'

module App
  module Services
    class BaseService
      include Dry::Monads::Result::Mixin
      attr_reader :request

      def self.call(request)
        new(request).call
      end

      def initialize(request)
        @request = request
      end
    end
  end
end
