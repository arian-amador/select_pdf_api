require 'yaml'
require 'httparty'

require 'select_pdf_api/yaml_file_config'
require 'select_pdf_api/exceptions'

# Main Select PDF API class.
class SelectPdfApi

	# @!attribute [r] config
	#   @return [Class] Config object used to parse options.
	attr_reader :config

	# @!attribute [rw] save_to
	#   @return [String] File to save the output PDF.
	attr_accessor :save_to

	# @!attribute [rw] url
	#   @return [String] Url of the page to create PDF from.
	attr_accessor :url

	# Base API URL
	API_URL = 'http://selectpdf.com/api'

	# Default Options merged when using the YamlFileConfig
	DEFAULT_OPTIONS = {
		config_file: "select-pdf-config.yml",
		save_to: "document.pdf"
	}

	# @!method initialize(user_opts)
	# @param [Hash] user_opts custom options provided by the user.
	# @option user_opts [String] url the url to create PDF from.
	# @option user_opts [String] config_file the file the configuration for the API params.
	# @option user_opts [String] save_to the file the output PDF file will be saved to.
	# @option user_opts [Class] config allows you to provide your own config class.
	def initialize(user_opts={})
		opts = DEFAULT_OPTIONS.merge user_opts

		@url 		 = opts[:url]
		@config  = opts[:config] || SelectPdfApi::YamlFileConfig.new(opts[:config_file])
		@save_to = opts[:save_to]
		@success = false
	end

	# @!method download
	# Sends a request to the API endpoint and downloads the file to the file system.
	# @raise [SelectPdfApi::DownloadError] if the url was not specified or if the request to the API endpoint fails.
	def download
		raise SelectPdfApi::DownloadError, "A URL must be specified." if @url.nil?

		request  = "#{API_URL}/?#{params}"
		response = HTTParty.get request

		if response.success?
			File.open(@save_to, "wb") {|f| f.write response.parsed_response}
			@success = true
		else
			raise SelectPdfApi::DownloadError, "There was an error with the following request #{request}"
		end
	end

	# @!method params
	# Sends a message to the Config Object being used and constructs the query string to be used by the download method.
	def params
		result = []
		@config.options.sort.map { |name, value| result << "#{name}=#{value}" }
		result << "url=#{@url}"
		result.join('&')
	end

	# @!method success?
	# @return [Boolean] Returns weather the latest download request was successful.
	def success?
		@success
	end

end