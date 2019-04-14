# frozen_string_literal: true

module App
  module Services
    module Users
      class ShowService < ::App::Services::BaseService
        def call
          find_user.fmap(&:values)
        end

        private

        def user_id
          request.path_info.to_s.match(%r{users\/([\d]+)}).captures.first
        end

        def find_user
          user = User.where(id: user_id).first
          user ? Success(user) : Failure(:user_not_found)
        end
      end
    end
  end
end
