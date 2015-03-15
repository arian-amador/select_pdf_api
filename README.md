# select-pdf-api

A wrapper for the [selectpdf.org](http://selectpdf.com/) public API.

The [selectpdf.org](http://selectpdf.com/) online API allows you to create PDFs from web pages and raw HTML code in your applications.

## Installation
Add this line to your application's Gemfile:

    gem 'select_pdf_api'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install select_pdf_api

You'll need to have a config folder and at least the default select-pdf-config.yml file. Inside your config folder you'll be able to have as many config.yml files as necessary.

    mkdir config
    touch select-pdf-config.yml

Inside your select-pdf-config.yml:
``` ruby
key: 'service api key'
```
See the [API Documentation](https://github.com/arian-amador/select_pdf_api/) for all the options. 

## Usage

##### Default
``` ruby
pdf_doc = SelectPdfApi.new({url: "http://www.google.com"})   # Load the default select-pdf-config.yml and setup the url to capture. 
pdf_doc.download   # Save result to the default ./document.pdf

```
##### Load a specific config per download
``` ruby

sites = [
  {url: "http://www.google.com", save_to: 'google_com.pdf'},
  {url: "http://mail.yahoo.com", save_to: 'mail_yahoo.pdf', 
    config_file: 'password-protected-yahoo.yml'}]

sites.each do |options|
  pdf = SelectPdfApi.new options
  pdf.download
end
```

##### Changing config options
``` ruby
pdf = SelectPdfApi.new   # Loads default config file.
pdf.config.load_config('wide_margins.yml')   # Load wide margin options.
pdf.download
```

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
