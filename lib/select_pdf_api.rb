require 'yaml'
require 'httparty'
require 'tempfile'

require 'select_pdf_api/config'
require 'select_pdf_api/exceptions'

class SelectPdfApi
	attr_accessor :config, :save_to, :url

	API_URL = 'http://selectpdf.com/api'

	API_QUERY_OPTIONS = %w{ page_size page_orientation pdf_name margin_top
		margin_right margin_bottom margin_left page_numbers user_password
		owner_password web_page_width web_page_height min_load_time max_load_time }

	DEFAULT_OPTIONS = {
		config: "select-pdf-config.yml"
	}

	def initialize(user_opts={})
		opts = DEFAULT_OPTIONS.merge user_opts

		@url 		 = opts[:url]
		@config = SelectPdfApi::Config.new opts[:config]
		@save_to = opts[:save_to] || temp_file
	end

	def download
		raise SelectPdfApi::DownloadError, "A URL must be specified." if @url.nil?

		request  = "#{API_URL}/?#{build_query}&url=#{@url}"
		response = HTTParty.get request

		if response.success?
			File.open(@save_to, "wb") {|f| f.write response.parsed_response}
		else
			raise SelectPdfApi::DownloadError, "There was an error with the following request #{request}"
		end
	end

	def build_query

		query_string = ["key=#{@config.api_key}"]

		#TODO Should be dynamic from config instace_variables
		API_QUERY_OPTIONS.each do |option|
			query_string << "#{option}=#{@config.send(option)}" if @config.respond_to? option
		end

		query_string.join('&')
	end

	private

		def temp_file
			temp = Tempfile.new('pdf')
			tempname = temp.path
			temp.close
			tempname
		end

end