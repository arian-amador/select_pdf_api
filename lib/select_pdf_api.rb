require 'yaml'
require 'httparty'

require 'select_pdf_api/env_config'
require 'select_pdf_api/yaml_config'
require 'select_pdf_api/exceptions'

# Main Select PDF API class.
class SelectPdfApi

	# @!attribute [r] config
	#   @return [Object] Config object used to parse options.
	attr_reader :config

	# @!attribute [rw] save_to
	#   @return [String] File to save the output PDF.
	attr_accessor :save_to

	# @!attribute [rw] url
	#   @return [String] Url of the page to create PDF from.
	attr_accessor :url

	# Base API URL
	API_END_POINT = 'http://selectpdf.com/api'

	# @!method initialize(opts)
	# @param [Hash] opts custom options provided by the user.
	# @option opts [String] url the url to create PDF from.
	# @option opts [Class] config allows you to provide your own config class.
	# @option opts [String] save_to the file the output PDF file will be saved to.
	def initialize(opts={})
		@url 		 = opts[:url]
		@config  = opts[:config] || SelectPdfApi::YamlConfig.new
		@save_to = opts[:save_to] || "document.pdf"
		@success = false
	end

	# @!method download
	# Sends a request to the API endpoint and downloads the file to the file system.
	# @raise [SelectPdfApi::DownloadError] if the url was not specified or if the request to the API endpoint fails.
	def download
		@success = false
		raise SelectPdfApi::DownloadError, "A URL must be specified." if @url.nil?

		request  = "#{API_END_POINT}/?#{params}"
		response = HTTParty.get request

		if response.success?
			save_pdf(response.parsed_response)
		else
			raise SelectPdfApi::DownloadError, "There was an error with the following request #{request}"
		end
	end

	# @!method params
	# Sends a message to the Config Object being used and constructs the query string to be used by the download method.
	def params
		result = []
		@config.options.sort.map { |name, value| result << "#{name}=#{value}" unless value.empty?	}
		result << "url=#{@url}"
		result.join('&')
	end

	# @!method success?
	# @return [Boolean] returns weather the latest download request was successful.
	def success?
		@success
	end

	private

		def save_pdf(data)
			File.open(@save_to, "wb") {|f| f.write data}
			@success = true
		end
end