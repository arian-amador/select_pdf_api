require './test/minitest_helper'

# API test
describe SelectPdfApi do
	let(:valid_url) 	{'http://www.google.com'}
	let(:select_pdf) { SelectPdfApi.new({url: valid_url}) }
	let(:valid_select_pdf) {
		SelectPdfApi.new({
			url: valid_url,
			config: '../test/fixtures/select-pdf-config.yml'
		})
	}
	let(:another_select_pdf) {
		SelectPdfApi.new({
			url: valid_url,
			config: '../test/fixtures/all-options-config.yml'
		})
	}
	let(:invalid_url) { SelectPdfApi.new({url: 'invalid_url'}) }

	def test_it_exists
		assert select_pdf
		select_pdf.must_be_instance_of SelectPdfApi
	end

	def test_url_should_be_changable
		test_url = "http://mail.yahoo.com"
		select_pdf.url.must_equal valid_url
		select_pdf.url = test_url
		select_pdf.url.must_equal test_url
	end

	def test_save_to_should_be_changable
		original_filename = "/tmp/test_file_1.tmp"
		modified_filename = "/tmp/test_file_9.tmp"

		new_select = SelectPdfApi.new({url: valid_url, save_to: original_filename})
		new_select.save_to.must_equal original_filename
		new_select.save_to = modified_filename
		new_select.save_to.must_equal modified_filename
	end

	def test_url_should_be_changable
		modified_url = "http://mail.yahoo.com"
		select_pdf.url.must_equal valid_url
		select_pdf.url = modified_url
		select_pdf.url.must_equal modified_url
	end

	def test_config_api_key_should_be_changable
		modified_api_key = "new_random_value_for_the_api_key123"

		valid_select_pdf.config.api_key.must_equal 'random-valid-api-123abc-345dbc'
		valid_select_pdf.config.api_key = modified_api_key
		valid_select_pdf.config.api_key.must_equal modified_api_key
	end

	describe "#build_query" do
		def test_it_builds_a_valid_query_string_with_options
			result = "key=api_key&page_size=Letter&page_orientation=Landscape&margin_right=2&margin_bottom=2&margin_left=1.25&user_password=user-password&owner_password=owner-password"
			another_select_pdf.build_query.must_equal result
		end
	end

	describe "#download" do
		def test_it_has_download
			select_pdf.must_respond_to 'download'
		end

		def test_it_fails_without_a_url
			-> {SelectPdfApi.new.download}.must_raise SelectPdfApi::DownloadError
		end

		def test_it_fails_with_an_invalid_url
			VCR.use_cassette('download_with_invalid_url', :record => :new_episodes) do
				-> {invalid_url.download}.must_raise SelectPdfApi::DownloadError
			end
		end

		def test_it_downloads_a_pdf
			VCR.use_cassette('download', :record => :new_episodes) do
				select_pdf.download
			end
		end
	end
end