require './test/minitest_helper'

# API test
describe SelectPDF do
	let(:select_pdf) {SelectPDF.new}
	let(:another_select_pdf) {
		SelectPDF.new SelectPDF::Config.new('../test/fixtures/all-options-config.yml')
	}
	let(:valid_url) 	{'http://www.google.com'}
	let(:invalid_url) {'invalid_url'}



	def test_it_exists
		assert select_pdf
		select_pdf.must_be_instance_of SelectPDF
	end

	def test_it_builds_a_valid_query_string_with_options
		res_query = "key=api_key&page_size=Letter&page_orientation=Landscape&margin_right=2&margin_bottom=2&margin_left=1.25&user_password=user-password&owner_password=owner-password"
		another_select_pdf.build_query.must_equal res_query
	end

	describe "#download" do
		def test_it_has_download
			select_pdf.must_respond_to 'download'
		end

		def test_it_fails_without_a_url
			-> {select_pdf.download}.must_raise SelectPDF::DownloadError
		end

		def test_it_fails_with_an_invalid_url
			VCR.use_cassette('download_with_invalid_url') do
				-> {select_pdf.download invalid_url}.must_raise SelectPDF::RequestError
			end
		end

		def test_it_downloads_a_pdf
			VCR.use_cassette('download') do
				select_pdf.download valid_url
			end
		end
	end
end

# Config test
describe SelectPDF::Config do
	let(:minimum_config) {SelectPDF::Config.new}
	let(:all_options_config) {SelectPDF::Config.new '../test/fixtures/all-options-config.yml'}
	let(:blank_config) {SelectPDF::Config.new '../test/fixtures/blank-config.yml'}
	let(:invalid_config) {SelectPDF::Config.new 'invalid_config'}

	def test_it_should_fail_with_an_invalid_config
		-> {invalid_config}.must_raise SelectPDF::ConfigError
	end

	def test_it_should_fail_with_a_blank_config
		-> {blank_config}.must_raise SelectPDF::ConfigError
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