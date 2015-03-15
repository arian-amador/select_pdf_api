# coding: utf-8
$:.push File.expand_path("../lib", __FILE__)
require 'select_pdf_api/version'

Gem::Specification.new do |spec|
  spec.name          = "select_pdf_api"
  spec.version       = SelectPdfApi::VERSION
  spec.authors       = ["Arian Amador"]
  spec.email         = ["arian@arianamador.com"]
  spec.summary       = %q{Wrapper library for the Select PDF service.}
  spec.description   = %q{Wrapper library for the Select PDF service. SelectPdf offers a REST API that can be used to convert html to pdf in any language with our dedicated web service.}
  spec.homepage      = "https://www.github.com/arian-amador/select_pdf_api"
  spec.licenses      = ["MIT"]

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.post_install_message = "PDF all the web of things!"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_development_dependency "vcr", '~> 2.9', '>= 2.9.3'
  spec.add_development_dependency "webmock", '~> 1.20', '>= 1.20.4'
  spec.add_development_dependency 'minitest', '~> 5.5', '>= 5.5.1'

  spec.add_dependency "httparty", "~> 0.13.3"
end
