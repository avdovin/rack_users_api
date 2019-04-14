# frozen_string_literal: true

module App
  module Responses
    module Result
      class BaseResponse
        attr_reader :body

        def headers
          { 'Content-Type' => 'application/json' }
        end

        def call
          [status, headers, body_json]
        end

        def body_json
          [body.to_json]
        end

        def self.call(body)
          new(body).call
        end

        def initialize(body)
          @body = body
        end
      end
    end
  end
end
