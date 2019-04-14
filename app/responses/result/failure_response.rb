# frozen_string_literal: true

module App
  module Responses
    module Result
      class FailureResponse < BaseResponse
        def status
          422
        end

        def body_json
          [
            { error: body }.to_json
          ]
        end
      end
    end
  end
end
