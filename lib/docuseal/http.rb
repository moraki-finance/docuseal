module Docuseal
  module HTTP
    def get(path:, **query)
      full_uri = uri(path:, query:)

      conn.get(full_uri) do |req|
        req.headers = headers
      end
    end

    def post(path:, body:, **query)
      full_uri = uri(path:, query:)

      conn.post(full_uri) do |req|
        req.body = body.to_json
        req.headers = headers
      end
    end

    def put(path:, body:, **query)
      full_uri = uri(path:, query:)

      conn.put(full_uri) do |req|
        req.body = body.to_json
        req.headers = headers
      end
    end

    def delete(path:, **query)
      full_uri = uri(path:, query:)

      conn.delete(full_uri) do |req|
        req.body = body.to_json
        req.headers = headers
      end
    end

    private

    def conn
      connection = Faraday.new do |f|
        f.options[:timeout] = request_timeout
        f.request :json
        f.response :json
        f.response :raise_error
      end

      @faraday_middleware&.call(connection)

      connection
    end

    def uri(path:, query: {})
      File.join(base_uri, path) + "?#{URI.encode_www_form(query)}"
    end

    def headers
      {
        "X-Auth-Token" => api_key
      }.merge(extra_headers)
    end
  end
end
