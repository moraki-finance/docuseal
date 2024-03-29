# Docuseal API Connector

<a href="https://codecov.io/github/moraki-finance/docuseal" >
 <img src="https://codecov.io/github/moraki-finance/docuseal/graph/badge.svg?token=SKTT14JJGV"/>
</a>

[![Tests](https://github.com/moraki-finance/docuseal/actions/workflows/main.yml/badge.svg?branch=main)](https://github.com/moraki-finance/docuseal/actions/workflows/main.yml)

A lightweight API connector for docuseal. Docuseal API docs: https://www.docuseal.co/docs/api

:warning: The extracted API objects don't do input parameters validations. It's a simple faraday wrapper that allows you to send as many inputs as you want. The docuseal API might fail when passing a wrong set of parameters.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add docuseal

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install docuseal

## Usage

### Setup

You'll need to set the Docuseal API key in the configuration.

```rb
Docuseal.configure do |config|
  config.api_key = "{DOCUSEAL_API_KEY}"
end
```

You can also set some other configurations like:

```rb
Docuseal.configure do |config|
  config.api_key = "{DOCUSEAL_API_KEY}"

  # Set the docuseal API request timeout, the default is 120 seconds
  config.request_timeout = 20

  # Set extra headers that will get attached to every docuseal api request.
  # Useful for observability tools like Helicone: https://www.helicone.ai/
  config.global_headers = {
    "Helicone-Auth": "Bearer HELICONE_API_KEY"
    "helicone-stream-force-format" => "true",
  }

  # Set the base_uri to use the docuseal EU servers if you're account was registered there.
  # The default is https://api.docuseal.co/
  config.base_uri = "https://api.docuseal.eu/"
end
```

### Submissions

#### List

Reference: https://www.docuseal.co/docs/api#list-all-submissions

```rb
submissions = Docuseal::Submission.list
```

#### Find

Reference: https://www.docuseal.co/docs/api#get-a-submission

```rb
submission = Docuseal::Submission.find(1)
```

#### Create

Reference: https://www.docuseal.co/docs/api#create-a-submission

```rb
submission = Docuseal::Submission.create(
  template_id: 1000001,
  send_email: true,
  submitters: [{role: 'First Party', email: 'john.doe@example.com'}]
)
```

#### Create From Email

Reference: https://www.docuseal.co/docs/api#create-submissions-from-emails

```rb
submission = Docuseal::Submission.create(
  from: :emails,
  template_id: 1000001,
  emails: 'hi@docuseal.co, example@docuseal.co'
)
```

#### Archive

Reference: https://www.docuseal.co/docs/api#archive-a-submission

```rb
submission = Docuseal::Submission.archive(1)
```

### Submitters

#### List

Reference: https://www.docuseal.co/docs/api#list-all-submitters

```rb
submitters = Docuseal::Submitter.list
```

#### Find

Reference: https://www.docuseal.co/docs/api#get-a-submitter

```rb
submitter = Docuseal::Submitter.find(1)
```

#### Update

Reference: https://www.docuseal.co/docs/api#update-a-submitter

```rb
submitter = Docuseal::Submitter.update(1,
  email: 'john.doe@example.com',
  fields: [{name: 'First Name', default_value: 'Acme'}]
)
```

### Templates

#### List

Reference: https://www.docuseal.co/docs/api#list-all-templates

```rb
templates = Docuseal::Template.list
```

#### Find

Reference: https://www.docuseal.co/docs/api#get-a-template

```rb
template = Docuseal::Template.find(1)
```

#### Create From DOCX

Reference: https://www.docuseal.co/docs/api#create-a-template-from-word-docx

```rb
template = Docuseal::Template.create(
  from: :docx,
  name: 'Demo DOCX',
  documents: [{ name: 'Demo DOCX', file: 'base64' }]
)
```

#### Create From HTML

Reference: https://www.docuseal.co/docs/api#create-a-template-from-html

```rb
template = Docuseal::Template.create(
  from: :html,
  html: '<p>Lorem Ipsum is simply dummy text of the\n<text-field\n  name="Industry"\n  role="First Party"\n  required="false"\n  style="width: 80px; height: 16px; display: inline-block; margin-bottom: -4px">\n</text-field>\nand typesetting industry</p>\n',
  name: 'Test Template'
)
```

#### Create From PDF

Reference: https://www.docuseal.co/docs/api#create-a-template-from-existing-pdf

```rb
template = Docuseal::Template.create(
  from: :pdf,
  name: 'Test PDF',
  documents: [
    {
      name: 'string',
      file: 'base64',
      fields: [{name: 'string', areas: [{x: 0, y: 0, w: 0, h: 0, page: 0}]}]
    }
  ]
)
```

#### Clone

Reference: https://www.docuseal.co/docs/api#clone-a-template

```rb
template = Docuseal::Template.clone(1,
  name: 'Clone of Test',
)
```

#### Update

Reference: https://www.docuseal.co/docs/api#update-a-template

```rb
template = Docuseal::Template.update(1,
  name: 'New Document Name',
  folder_name: 'New Folder'
)
```

#### Update Documents

Reference: https://www.docuseal.co/docs/api#update-template-documents

```rb
template = Docuseal::Template.update_documents(1,
  documents: [{file: 'base64'}]
)
```

#### Archive

Reference: https://www.docuseal.co/docs/api#archive-a-template

```rb
template = Docuseal::Template.archive(1)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment:

```bash
$ DOCUSEAL_API_KEY={YOUR API KEY} DOCUSEAL_BASE_URI={YOUR BASE URI} bin/console
```

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/moraki-finance/docuseal. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/moraki-finance/docuseal/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Docuseal project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/docuseal/blob/main/CODE_OF_CONDUCT.md).
