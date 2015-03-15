class SelectPdfApi
	# Default config class used to store API options and key.
	class YamlFileConfig

		# @!method initialize(filename)
		# @param [String] filename Config file to be loaded.
		def initialize(filename)
			@data = {}
			load_config filename
		end

		# @!method load_config(filename)
		# @param [String] filename Config file to be loaded.
		# @raise [SelectPdfApi::ConfigError] if config file does not exist.
		# @raise [SelectPdfApi::ConfigError] if config file is empty.
		def load_config(filename)
			config_file = File.join(File.expand_path(File.join('config')), filename)

			raise SelectPdfApi::ConfigError, "Config file #{config_file} does not exist." unless
				File.exist? config_file

			@data = YAML::load_file(config_file)

			raise SelectPdfApi::ConfigError, "Error loading values from #{config_file}" unless @data
		end

		# @!method options
		# @return [Hash] Collection of options loaded from the config file.
		def options
			@data
		end
	end
end