$:.unshift File.expand_path('../../lib', __FILE__)
require 'select_pdf_api'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
	config = SelectPdfApi::Config.new

	c.allow_http_connections_when_no_cassette = false
	c.filter_sensitive_data('<API_KEY>') { config.api_key }
  c.cassette_library_dir = "test/fixtures/vcr"
  c.hook_into :webmock
end