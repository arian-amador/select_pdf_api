require './test/minitest_helper'

# Config test
describe SelectPdfApi::YamlConfig do
	let(:fixtures)			 {"../test/fixtures"}

	let(:blank_config) 	 {SelectPdfApi::YamlConfig.new("#{fixtures}/blank-config")}
	let(:minimum_config) {SelectPdfApi::YamlConfig.new("#{fixtures}/minimum-config")}
	let(:maximum_config) {SelectPdfApi::YamlConfig.new("#{fixtures}/all-config")}
	let(:invalid_config) {SelectPdfApi::YamlConfig.new('invalid_config')}

	def test_it_should_fail_with_an_invalid_config
		-> {invalid_config}.must_raise SelectPdfApi::ConfigError
	end

	def test_it_should_fail_with_a_blank_config
		-> {blank_config}.must_raise SelectPdfApi::ConfigError
	end

	def test_valid_options_for_minimium_config
		result = {"key"=>"random-valid-api-123abc-345dbc"}
		minimum_config.options.must_equal result
	end

	def test_valid_options_for_all_options_config
		result = {"key"=>"valid-key-123-67ad", "page_size"=>"Letter", "page_orientation"=>"Landscape", "margin_right"=>"2pt", "margin_bottom"=>"2pt", "margin_left"=>"1.25pt", "user_password"=>"user123", "owner_password"=>"owner567"}
		maximum_config.options.must_equal result
	end

	def test_it_loads_a_new_config
		original = {"key"=>"random-valid-api-123abc-345dbc"}
		modified = {"key"=>"valid-key-123-67ad", "page_size"=>"Letter", "page_orientation"=>"Landscape", "margin_right"=>"2pt", "margin_bottom"=>"2pt", "margin_left"=>"1.25pt", "user_password"=>"user123", "owner_password"=>"owner567"}

		config = SelectPdfApi::YamlConfig.new("#{fixtures}/minimum-config")
		config.options.must_equal original
		config.load_config("#{fixtures}/all-config")
		config.options.must_equal modified
	end
end
