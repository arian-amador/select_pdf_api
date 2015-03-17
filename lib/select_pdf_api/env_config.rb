class SelectPdfApi
	# Config class using the ENV variable or the API key.
	class EnvConfig

		# API Options Hash
		attr_reader :data

		# API Options list
		API_OPTIONS = %w{key page_size page_orientation pdf_name margin_top margin_right margin_bottom margin_left
			page_numbers user_password owner_password web_page_width web_page_height}

		# @!method initialize(env_var)
		# @param [String] env_var Name of the environment variable the API key is set to.
		# @return [Object] SelectPdfApi::EnvConfig
		def initialize(env_var='SELECT_PDF_KEY')
			@env_var = env_var
			configure_options
		end

		# @!method configure_options
		# Sets the initial values for the API options.
		# The API key is set from the environment variable.
		# @return [Hash] API options with API key set.
		def configure_options
			@data = {}
			API_OPTIONS.each {|option| @data[option] = ''}
			@data['key'] = ENV[@env_var]
			@data
		end

		# @!method options
		# Required by all config classes as the common interface for the main class.
		# @return [Hash] Collection of options loaded from the config file.
		def options
			@data.delete_if{|k, v| v.empty?}
		end
	end
end