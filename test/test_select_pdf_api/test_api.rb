require './test/minitest_helper'

# API test
describe SelectPdfApi do
	let(:fixtures)			 {"../test/fixtures"}
	let(:minimum_config) {"#{fixtures}/minimum-config.yml"}
	let(:maximum_config) {"#{fixtures}/all-config.yml"}
	let(:blank_config)   {"#{fixtures}/blank-config.yml"}

	let(:select_pdf)  {SelectPdfApi.new({url: 'http://www.google.com', config_file: minimum_config})}

	before do
		select_pdf.config.load_config(minimum_config)
	end

	def test_class_exists
		assert select_pdf
		select_pdf.must_be_instance_of SelectPdfApi
	end

	def test_save_to_should_be_changable
		modified_filename = "/tmp/test_file_9.tmp"
		select_pdf.save_to.must_equal "document.pdf"
		select_pdf.save_to = modified_filename
		select_pdf.save_to.must_equal modified_filename
	end

	def test_url_should_be_changable
		modified_url = "http://mail.yahoo.com"
		select_pdf.url.must_equal 'http://www.google.com'
		select_pdf.url = modified_url
		select_pdf.url.must_equal modified_url
	end

	describe "#params" do
		def test_params_exists
			select_pdf.must_respond_to 'params'
		end

		def test_it_should_build_params_for_all_options
			select_pdf.config.load_config(maximum_config)
			select_pdf.params.must_equal "key=valid-key-123-67ad&margin_bottom=2pt&margin_left=1.25pt&margin_right=2pt&owner_password=owner567&page_orientation=Landscape&page_size=Letter&user_password=user123&url=http://www.google.com"
		end

		def test_it_should_build_params_for_minimum_options
			select_pdf.config.load_config(minimum_config)
			select_pdf.params.must_equal "key=random-valid-api-123abc-345dbc&url=http://www.google.com"
		end
	end

	describe "#download" do
		def test_download_exists
			select_pdf.must_respond_to 'download'
		end

		def test_it_fails_without_a_url
			-> {select_pdf.download}.must_raise SelectPdfApi::DownloadError
		end
	end
end