# frozen_string_literal: true

module App
  class Rack
    def call(env)
      request = ::Rack::Request.new(env)
      handle_request(request)
    end

    private

    def handle_request(request)
      http_verb = request.request_method

      case request.path_info
      when %r{users\/([\d]+)$}
        result = Services::Users::ShowService.call(request)
        Responses::ResultResponse.call(result)
      when /users$/
        if http_verb == 'POST'
          result = Services::Users::CreateService.call(request)
          Responses::ResultResponse.call(result)
        elsif http_verb == 'GET'
          result = Services::Users::IndexService.call(request)
          Responses::ResultResponse.call(result)
        end
      else
        not_found
      end
    end

    def not_found
      [404, { 'Content-Type' => 'text/html' }, ['not_found']]
    end
  end
end
