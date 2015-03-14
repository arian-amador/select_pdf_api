require 'httparty'

require 'select_pdf/config'
require 'select_pdf/exceptions'

class SelectPDF

	attr_reader :config

	API_URL = 'http://selectpdf.com/api'
	API_QUERY_OPTIONS = %w{ page_size page_orientation pdf_name margin_top
		margin_right margin_bottom margin_left page_numbers user_password
		owner_password web_page_width web_page_height min_load_time max_load_time }

	def initialize(config=SelectPDF::Config.new)
		@config = config
	end

	def download(url=nil)
		raise SelectPDF::DownloadError, "A URL must be specified." if url.nil?

		temp = Tempfile.new('pdf')
		tempname = temp.path
		temp.close

		response = HTTParty.get "#{API_URL}/?#{build_query}&url=#{url}"

		if response.success?
			File.open(tempname, "wb") {|f| f.write response.parsed_response}
		else
			raise SelectPDF::RequestError
		end
	end

	def build_query

		query_string = ["key=#{@config.api_key}"]

		# puts (@config.methods - Object.methods)

		API_QUERY_OPTIONS.each do |option|
			query_string << "#{option}=#{@config.send(option)}" if @config.respond_to? option
		end
		query_string.join('&')
	end
end