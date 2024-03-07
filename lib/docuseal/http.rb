module Docuseal
  module HTTP
    def get(path, headers: {}, **query)
      full_uri = uri(path:, query:)

      conn.get(full_uri) do |req|
        req.headers = all_headers(headers)
      end
    end

    def post(path, data: {}, headers: {}, **query)
      full_uri = uri(path:, query:)

      conn.post(full_uri) do |req|
        req.body = data.to_json if data.any?
        req.headers = all_headers(headers)
      end
    end

    def put(path, data: {}, headers: {}, **query)
      full_uri = uri(path:, query:)

      conn.put(full_uri) do |req|
        req.body = data.to_json if data.any?
        req.headers = all_headers(headers)
      end
    end

    def delete(path, headers: {}, **query)
      full_uri = uri(path:, query:)

      conn.delete(full_uri) do |req|
        req.headers = all_headers(headers)
      end
    end

    private

    def conn
      Faraday.new do |f|
        f.options[:timeout] = request_timeout
        f.request :json
        f.response :json
        f.response :raise_error
      end
    end

    def uri(path:, query: {})
      File.join(base_uri, path) + "?#{URI.encode_www_form(query)}"
    end

    def all_headers(request_headers = {})
      {
        "X-Auth-Token" => api_key
      }.merge(global_headers).merge(request_headers)
    end
  end
end
