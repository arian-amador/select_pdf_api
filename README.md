# select_pdf_api

[![Gem Version](https://badge.fury.io/rb/select_pdf_api.svg)](http://badge.fury.io/rb/select_pdf_api)    [![Build Status](https://travis-ci.org/arian-amador/select_pdf_api.svg?style=flat)](https://travis-ci.org/arian-amador/select_pdf_api)    [![Inline docs ](https://inch-ci.org/github/arian-amador/select_pdf_api.svg?branch=master)](https://inch-ci.org/github/arian-amador/select_pdf_api)

A wrapper for the [selectpdf.com](http://selectpdf.com/) public API.

The [selectpdf.com](http://selectpdf.com/) online API allows you to create PDFs from web pages and raw HTML code in your applications.

## Installation
Add this line to your application's Gemfile:

    gem "select_pdf_api"

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install select_pdf_api

## Usage
``` ruby
pdf_doc = SelectPdfApi.new({url: "http://www.google.com"})   # Load the default ./config/select-pdf-config.yml and set the url to capture
pdf_doc.download   # Save result to the default ./document.pdf

```
Loada a different YAML config files using for default YamlConfig class:
``` ruby
pdf_doc = SelectPdfApi.new
pdf_doc.config.load_config("wide_margins.yml")
pdf_doc.download
```
Modify existing options:
``` ruby
pdf_doc = SelectPdfApi.new
pdf_doc.config.options['key'] = ENV["SELECT_PDF_API"]   # Set key from ENV variable
pdf_doc.config.options['user_password'] = "password123" # Set password when opening PDF
pdf_doc.download

```
## Config
By default the YamlConfig class is used to parse a `yml` file that holds all API options including the API key. You'll need to have a config folder and at minimum
`select-pdf-config.yml`.

```ruby
# Inside your project folder:
$ mkdir config
$ touch select-pdf-config.yml

# Yaml file contents
key: "service api key"
other_options: ...
```
Loading your API key from an environment variable is also easy using the available EnvConfig class.
```ruby
env_config = SelectPdfApi::EnvConfig.new() # Uses the default ENV['SELECT_PDF_KEY']
custom_env = SelectPdfApi::EnvConfig.new('MY_SELECT_KEY') # Uses the user provided ENV['MY_SELECT_KEY']

pdf_select = SelectPdfApi.new({url: "http://www.google.com", config: env_config})
pdf_select.config.options['key']   # Returns the API key
```

It's also possible to create your own Config class as long as it has an `options` method that returns a `Hash` of options.
``` ruby
require "select_pdf_api"

class SelectConfig
  class ActiveDirectoryConfig

  # ... snip ...

    def options
      # Returns [Hash] of options
    end
  end
end

pdf_select = SelectPdfApi.new({url: "http://www.google.com", config: SelectConfig::TestConfig.new})
pdf_select.config.options   # Return [Hash] from custom class

```

See the [API Documentation](https://github.com/arian-amador/select_pdf_api/) for all the options.

## Documentation
* API - http://selectpdf.com/html-to-pdf-api/
* Rubydoc - http://www.rubydoc.info/github/arian-amador/select_pdf_api/master
* GitHub - https://github.com/arian-amador/select_pdf_api/

## Contributing
1. Fork it ( https://github.com/arian-amador/select_pdf_api/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
