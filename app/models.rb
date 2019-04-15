# frozen_string_literal: true

DB = Sequel.connect("sqlite://api_#{ENV['APP_MODE']}.db")
require_relative 'models/user'
