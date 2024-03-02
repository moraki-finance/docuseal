if ENV["COVERAGE_DIR"]
  require "simplecov"
  SimpleCov.coverage_dir(ENV["COVERAGE_DIR"])
  if ENV["CI"]
    require "simplecov-cobertura"
    SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
  end
  SimpleCov.start
end

require "bundler/setup"
require "webmock/rspec"
require "docuseal"
Bundler.require(:default, :development, :test)

Dir[File.expand_path("spec/support/**/*.rb")].sort.each { |f| require f }

def docuseal_url(base_uri, path:, query: {})
  File.join(base_uri, path) + "?#{URI.encode_www_form(query)}"
end

def docuseal_fixture(name)
  JSON.parse(File.read(File.join(RSPEC_ROOT, "support", "fixtures", "#{name}.json")))
end

def stub_docuseal(method, resource, headers: nil, query: {}, body: {})
  stub_request(
    method,
    docuseal_url(Docuseal::Client.instance.base_uri, path: "/#{resource}", query:)
  )
    .with({body: hash_including(body)}.merge(headers ? {headers: headers} : {}))
    .to_return(
      status: 200,
      body: docuseal_fixture("#{method}_#{resource}").to_json,
      headers: {"Content-Type" => "application/json"}
    )
end

RSpec.configure do |c|
  # Enable flags like --only-failures and --next-failure
  c.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  c.disable_monkey_patching!

  c.expect_with :rspec do |rspec|
    rspec.syntax = :expect
  end

  if ENV.fetch("DOCUSEAL_API_KEY", nil)
    warning = "WARNING! Specs are hitting the Docuseal API! This is very slow! If you don't want this, unset
    DOCUSEAL_API_KEY to run against the stored VCR responses.".freeze

    warning = RSpec::Core::Formatters::ConsoleCodes.wrap(warning, :bold_red)

    c.before(:suite) { RSpec.configuration.reporter.message(warning) }
    c.after(:suite) { RSpec.configuration.reporter.message(warning) }
  end

  c.before(:all) do
    Docuseal.configure do |config|
      config.api_key = ENV.fetch("DOCUSEAL_API_KEY", "fake_api_key")
    end
  end
end

RSPEC_ROOT = File.dirname __FILE__
