# frozen_string_literal: true

require 'active_support'
require 'base64'
require 'rest-client'
require 'mustache'
require 'json'

require_relative 'accomplished/version'
require_relative 'accomplished/azure_devops'
require_relative 'accomplished/work_item'

module Accomplished
  class Error < StandardError; end
end
