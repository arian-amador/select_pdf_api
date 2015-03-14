$:.unshift File.expand_path('../../lib', __FILE__)
$:.unshift File.expand_path('../../config', __FILE__)
require 'select_pdf_api'

require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
	c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = "test/fixtures/vcr"
  c.hook_into :webmock
end