require "faraday"

require_relative "docuseal/http"
require_relative "docuseal/client"
require_relative "docuseal/model"
require_relative "docuseal/submission"
require_relative "docuseal/submitter"
require_relative "docuseal/template"

module Docuseal
  class Error < StandardError; end

  class ConfigurationError < Error; end

  class Configuration
    attr_accessor :request_timeout, :base_uri, :global_headers
    attr_writer :api_key

    DEFAULT_BASE_URI = "https://api.docuseal.co/".freeze
    DEFAULT_REQUEST_TIMEOUT = 120

    def initialize
      @api_key = nil
      @request_timeout = DEFAULT_REQUEST_TIMEOUT
      @base_uri = DEFAULT_BASE_URI
      @global_headers = {}
    end

    def api_key
      @api_key || (raise ConfigurationError, "Docuseal api_key missing!")
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
