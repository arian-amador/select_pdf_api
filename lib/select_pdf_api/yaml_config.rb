class SelectPdfApi
	# Default config class used to store API options and key.
	class YamlConfig

		# API Options Hash
		attr_accessor :data

		# @!method initialize(filename)
		# @param [String] filename Config file to be loaded.
		def initialize(config_file="select-pdf-config")
			load_config config_file
		end

		# @!method load_config(filename)
		# @param [String] filename Config file to be loaded.
		# @raise [SelectPdfApi::ConfigError] if config file does not exist.
		# @raise [SelectPdfApi::ConfigError] if config file is empty.
		# @return [Hash] Options loaded from config file.
		def load_config(config_file)
			config_file_with_path = File.join(File.expand_path(File.join('config')), "#{config_file}.yml")

			raise SelectPdfApi::ConfigError, "Config file #{config_file_with_path} does not exist." unless
				File.exist? config_file_with_path

			@data = {}
			@data = YAML::load_file(config_file_with_path)

			raise SelectPdfApi::ConfigError, "Error loading values from #{config_file_with_path}" unless @data

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