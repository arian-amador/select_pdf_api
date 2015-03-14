$:.unshift File.expand_path('../../lib', __FILE__)
require 'select_pdf'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
	config = SelectPDF::Config.new

	c.allow_http_connections_when_no_cassette = true
	c.filter_sensitive_data('<API_KEY>') { config.api_key }
  c.cassette_library_dir = "test/fixtures/vcr"
  c.hook_into :webmock
end