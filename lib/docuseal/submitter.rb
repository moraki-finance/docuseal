module Docuseal
  class Submitter < Model
    not_allowed_to %i[create archive]

    def self.path
      "/submitters"
    end
  end
end
