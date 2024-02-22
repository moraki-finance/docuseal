module Docuseal
  class Submission < Model
    skip_coertion_for [:values]
    not_allowed_to [:update]

    def self.path
      "/submissions"
    end

    def self.create(from: nil, **attrs)
      if from
        super(path: "#{path}/#{from}", **attrs)
      else
        super(**attrs)
      end
    end
  end
end
