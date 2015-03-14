require 'yaml'

class SelectPDF
	class Config
		attr_reader :data

		def initialize(filename="select-pdf-config.yml")
			config_file = File.join(File.expand_path(File.join('config')), filename)
			raise SelectPDF::ConfigError, "Config file #{config_file} does not exist." unless
				File.exist? config_file

			@data = {}
			@data = YAML::load_file(config_file)
			raise SelectPDF::ConfigError, "Error reading #{config_file}." unless @data

			define_methods(@data.keys)
		end

		def define_methods(names)
			names.each do |name|
				self.class.class_eval <<-EORUBY
					def #{name}
						@data["#{name}"]
					end
				EORUBY
			end
		end
	end
end