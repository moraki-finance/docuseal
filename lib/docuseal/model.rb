module Docuseal
  class Model
    class << self
      def create(path: self.path, **attrs)
        raise Docuseal::Error, "Method not allowed" if not_allowed_to.include?(:create)

        response = Docuseal::Client.instance.post(path, data: attrs)
        body = response.body

        return body.map(&self) if body.is_a?(Array)

        new(body)
      end

      def find(id)
        raise Docuseal::Error, "Method not allowed" if not_allowed_to.include?(:find)

        response = Docuseal::Client.instance.get("#{path}/#{id}")
        new(response.body)
      end

      def update(id, **attrs)
        raise Docuseal::Error, "Method not allowed" if not_allowed_to.include?(:update)

        response = Docuseal::Client.instance.put("#{path}/#{id}", data: attrs)
        new(response.body)
      end

      def list(**)
        raise Docuseal::Error, "Method not allowed" if not_allowed_to.include?(:list)

        response = Docuseal::Client.instance.get(path, **)
        response.body["data"].map(&self)
      end

      def archive(id)
        raise Docuseal::Error, "Method not allowed" if not_allowed_to.include?(:archive)

        response = Docuseal::Client.instance.delete("#{path}/#{id}")
        new(response.body)
      end

      # Auxiliary methods

      def to_proc
        ->(attrs) { new(attrs) }
      end

      def skip_coertion_for(attrs = [])
        @skip_coertion_for ||= attrs
      end

      def not_allowed_to(attrs = [])
        @not_allowed_to ||= attrs
      end
    end

    def to_json
      @_raw.to_json
    end

    protected

    def initialize(attrs = {})
      @_raw = attrs

      attrs.each do |key, value|
        if self.class.skip_coertion_for.include?(key.to_sym)
          instance_variable_set("@#{key}", value)
        else
          coerced_value = if value.is_a?(Hash)
            Docuseal::Model.new(value)
          elsif value.is_a?(Array)
            value.map { |v| Docuseal::Model.new(v) }
          else
            value
          end
          instance_variable_set("@#{key}", coerced_value)
        end
      end

      instance_variables.each { |iv| self.class.send(:attr_reader, iv.to_s[1..].to_sym) }
    end
  end
end
