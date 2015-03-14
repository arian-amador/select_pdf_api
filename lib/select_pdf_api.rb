require 'yaml'
require 'httparty'
require 'tempfile'

require 'select_pdf_api/yaml_file_config'
require 'select_pdf_api/exceptions'

class SelectPdfApi
	attr_accessor :config, :save_to, :url

	API_URL = 'http://selectpdf.com/api'

	# TODO: Refactor this...
	DEFAULT_OPTIONS = {
		config_file: "select-pdf-config.yml"
	}

	def initialize(user_opts={})
		opts = DEFAULT_OPTIONS.merge user_opts

		@url 		 = opts[:url]
		@config  = opts[:config] || SelectPdfApi::YamlFileConfig.new(opts[:config_file])
		@save_to = opts[:save_to] || temp_file
		@success = false
	end

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

	def params
		result = []
		@config.options.sort.map { |name, value| result << "#{name}=#{value}" }
		result << "url=#{@url}"
		result.join('&')
	end

	def success?
		@success
	end

	def temp_file
		temp = Tempfile.new('pdf')
		tempname = temp.path
		temp.close
		tempname
	end

end