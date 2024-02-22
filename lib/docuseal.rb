require "faraday"

require_relative "docuseal/http"
require_relative "docuseal/client"
require_relative "docuseal/model"
require_relative "docuseal/submission"
require_relative "docuseal/submitter"
require_relative "docuseal/template"

module Docuseal
  VERSION = "0.0.1".freeze

  class Error < StandardError; end

  class ConfigurationError < Error; end

  class Configuration
    attr_writer :api_key, :request_timeout, :base_uri, :extra_headers
    attr_reader :base_uri, :request_timeout, :extra_headers

    DEFAULT_BASE_URI = "https://api.docuseal.eu/".freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @api_key = nil
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @base_uri = DEFAULT_BASE_URI
      @extra_headers = {}
    end

    def api_key
      return @api_key if @api_key
      raise ConfigurationError, "Docuseal api_key missing!"
    end
  end

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Docuseal::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
