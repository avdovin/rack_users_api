# frozen_string_literal: true

require 'json'

module App
  module Services
    module Users
      class CreateService < ::App::Services::BaseService
        def call
          parse_json(request.body.read).bind do |payload|
            validate_email_present(payload['email']).bind do |email|
              validate_email_format(payload['email']).bind do
                validate_email_unique(email).bind do
                  create_user(email).fmap(&:values)
                end
              end
            end
          end
        end

        private

        def create_user(email)
          user = User.create(email: email)
          if user.save
            Success(user)
          else
            Failure(:record_invalid)
          end
        end

        def parse_json(body)
          Success(JSON.parse(body))
        rescue JSON::ParserError
          Failure(:json_parse_error)
        end

        def validate_email_present(email)
          email.to_s.empty? ? Failure(:email_missing) : Success(email)
        end

        def validate_email_format(email)
          if URI::MailTo::EMAIL_REGEXP.match?(email)
            Failure(:wrong_email_format)
          else
            Success(email)
          end
        end

        def validate_email_unique(email)
          if User.where(email: email).count.zero?
            Success(email)
          else
            Failure(:email_already_exists)
          end
        end
      end
    end
  end
end
