module Docuseal
  class Model
    class << self
      def create(path: self.path, **attrs)
        response = Docuseal::Client.instance.post(path:, body: attrs)
        body = response.body

        return body.map(&self) if body.is_a?(Array)

        new(body)
      end

      def find(id)
        response = Docuseal::Client.instance.get(path: "#{path}/#{id}")
        new(response.body)
      end

      def update(id, **attrs)
        response = Docuseal::Client.instance.put(path: "#{path}/#{id}", body: attrs)
        new(response.body)
      end

      def list(**)
        response = Docuseal::Client.instance.get(path:, **)
        response.body["data"].map(&self)
      end

      def delete(id)
        Docuseal::Client.instance.delete(path: "#{path}/#{id}")
        true
      end

      def to_proc
        ->(attrs) { new(attrs) }
      end
    end

    protected

    def initialize(attrs = {})
      attrs.symbolize_keys.each do |key, value|
        coerced_value = if value.is_a?(Hash)
          Docuseal::Model.new(value)
        elsif value.is_a?(Array)
          value.map { |v| Docuseal::Model.new(v) }
        else
          value
        end
        instance_variable_set("@#{key}", coerced_value)
      end
      instance_variables.each { |iv| self.class.send(:attr_reader, iv.to_s[1..].to_sym) }
    end
  end
end
