# frozen_string_literal: true

module App
  module Services
    module Users
      class IndexService < ::App::Services::BaseService
        def call
          Success(User.all.map(&:values))
        end
      end
    end
  end
end
