class SelectPdfApi
	class YamlFileConfig

		def initialize(filename)
			@data = {}
			load_config filename
		end

		def load_config(filename)
			config_file = File.join(File.expand_path(File.join('config')), filename)

			raise SelectPdfApi::ConfigError, "Config file #{config_file} does not exist." unless
				File.exist? config_file

			@data = YAML::load_file(config_file)

			raise SelectPdfApi::ConfigError, "Error loading values from #{config_file}" unless @data
		end

		def options
			@data
		end
	end
end