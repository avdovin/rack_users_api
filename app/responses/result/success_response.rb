# frozen_string_literal: true

module App
  module Responses
    module Result
      class SuccessResponse < BaseResponse
        def status
          200
        end
      end
    end
  end
end
