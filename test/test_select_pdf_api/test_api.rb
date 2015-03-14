require './test/minitest_helper'

# API test
describe SelectPdfApi do
	let(:valid_url) 	{'http://www.google.com'}
	let(:invalid_url) { SelectPdfApi.new({url: 'invalid_url'}) }

	let(:default_config_api) { SelectPdfApi.new({url: valid_url})}
	let(:minimum_config_api) { SelectPdfApi.new({url: valid_url,
		config_file: '../test/fixtures/minimum-config.yml'})}
	let(:maximum_config_api) { SelectPdfApi.new({url: valid_url,
			config_file: '../test/fixtures/all-config.yml'})}

	def test_class_exists
		assert default_config_api
		default_config_api.must_be_instance_of SelectPdfApi
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

		default_config_api.url.must_equal valid_url
		default_config_api.url = modified_url
		default_config_api.url.must_equal modified_url
	end

	describe "#params" do
		def test_params_exists
			default_config_api.must_respond_to 'params'
		end

		def test_it_should_build_params_for_all_options
			maximum_config_api.params.must_equal "key=valid-key-123-67ad&margin_bottom=2pt&margin_left=1.25pt&margin_right=2pt&owner_password=owner567&page_orientation=Landscape&page_size=Letter&user_password=user123&url=http://www.google.com"
		end

		def test_it_should_build_params_for_minimum_options
			minimum_config_api.params.must_equal "key=random-valid-api-123abc-345dbc&url=http://www.google.com"
		end
	end

	describe "#download" do
		def test_download_exists
			default_config_api.must_respond_to 'download'
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
				default_config_api.download
				default_config_api.success?
			end
		end
	end
end