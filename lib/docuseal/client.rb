module Docuseal
  class Client
    include Docuseal::HTTP

    CONFIG_KEYS = %i[
      api_key request_timeout base_uri extra_headers
    ].freeze

    attr_reader(*CONFIG_KEYS)

    def self.instance
      @instance ||= new
    end

    private

    def initialize(config = {})
      CONFIG_KEYS.each do |key|
        # Set instance variables like api_type & access_token. Fall back to global config
        # if not present.
        instance_variable_set("@#{key}", config[key] || Docuseal.configuration.send(key))
      end
    end
  end
end
