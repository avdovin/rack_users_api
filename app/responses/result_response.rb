# frozen_string_literal: true

module App
  module Responses
    class ResultResponse
      attr_reader :result

      def self.call(result)
        new(result).call
      end

      def initialize(result)
        @result = result
      end

      def call
        if result.success?
          Result::SuccessResponse.call(result.value!)
        else
          Result::FailureResponse.call(result.failure)
        end
      end
    end
  end
end
