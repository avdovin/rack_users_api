# frozen_string_literal: true

DB = Sequel.connect('sqlite://api.db')

require_relative 'models/user'
