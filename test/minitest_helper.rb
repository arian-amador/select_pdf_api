$:.unshift File.expand_path('../../lib', __FILE__)

require 'select_pdf_api'
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

VCR.configure do |c|
	c.filter_sensitive_data('<KEY>') { ENV['SELECT_PDF_KEY'] }

  c.cassette_library_dir = "test/fixtures/vcr"
  c.hook_into :webmock
end