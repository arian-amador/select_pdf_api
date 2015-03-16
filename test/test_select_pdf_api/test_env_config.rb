require './test/minitest_helper'

# Config test
describe SelectPdfApi::EnvConfig do
	let(:select_pdf) {SelectPdfApi.new({
		url: "http://www.google.com",
		config: SelectPdfApi::EnvConfig.new
	})}

	def test_it_exists
		select_pdf.must_be_instance_of SelectPdfApi
		select_pdf.config.must_be_instance_of SelectPdfApi::EnvConfig
	end

	def test_key_is_loaded_from_env
		env_key = ENV['SELECT_PDF_KEY']
		select_pdf.config.options['key'].must_equal env_key
	end

	def test_options_must_be_changable
		original_key = ENV['SELECT_PDF_KEY']
		modified_key = "modified-key-123"

		select_pdf.config.options['key'].must_equal original_key
		select_pdf.config.options['key'] = modified_key
		select_pdf.config.options['key'].must_equal modified_key
	end
end