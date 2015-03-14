class SelectPdfApi
	class Config

		def initialize(filename)
			config_file = File.join(File.expand_path(File.join('config')), filename)

			raise SelectPdfApi::ConfigError, "Config file #{config_file} does not exist." unless
				File.exist? config_file

			define_methods load_data(config_file)
		end

		# TODO: Is this the best way to do this?
		def define_methods(names)
			names.each do |name, value|
        self.class.class_eval("def #{name}; @#{name}; end")
        self.class.class_eval("def #{name}=(val); @#{name}=val; end")
        instance_variable_set "@#{name}", value
			end
		end

		private
			def load_data(config_file)
				data = {}
				data = YAML::load_file(config_file)
				raise SelectPdfApi::ConfigError, "Error reading #{config_file}." unless data
				data
			end
	end
end