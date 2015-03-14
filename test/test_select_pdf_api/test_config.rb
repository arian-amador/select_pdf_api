require './test/minitest_helper'

# Config test
describe SelectPdfApi::Config do
	let(:minimum_config) {SelectPdfApi::Config.new '../test/fixtures/select-pdf-config.yml'}
	let(:all_options_config) {SelectPdfApi::Config.new '../test/fixtures/all-options-config.yml'}
	let(:blank_config) {SelectPdfApi::Config.new '../test/fixtures/blank-config.yml'}
	let(:invalid_config) {SelectPdfApi::Config.new 'invalid_config'}

	def test_it_should_fail_with_an_invalid_config
		-> {invalid_config}.must_raise SelectPdfApi::ConfigError
	end

	def test_it_should_fail_with_a_blank_config
		-> {blank_config}.must_raise SelectPdfApi::ConfigError
	end

	describe "Config with minimum settings ex: just the API key" do
		def test_it_exists
			assert minimum_config
		end

		def test_it_should_have_api_key
			minimum_config.must_respond_to 'api_key'
		end
	end

	describe "Config with all options setup" do
		def test_it_should_load_default_config
			assert all_options_config
		end

		def test_it_should_load_specified_config
			all_options_config.api_key.must_equal "api_key"
			all_options_config.output.must_equal "/tmp/document.pdf"
			all_options_config.page_size.must_equal "Letter"
			all_options_config.page_orientation.must_equal "Landscape"
			all_options_config.margin_right.must_equal "2"
			all_options_config.margin_bottom.must_equal "2"
			all_options_config.margin_left.must_equal "1.25"
			all_options_config.margin_left.must_equal "1.25"
			all_options_config.user_password.must_equal "user-password"
			all_options_config.owner_password.must_equal "owner-password"
		end
	end
end
