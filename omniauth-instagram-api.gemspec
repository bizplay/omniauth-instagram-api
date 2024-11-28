# frozen_string_literal: true

require_relative "lib/omniauth-instagram-api/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-instagram-api"
  spec.version = OmniAuth::InstagramAPI::VERSION
  spec.authors = ["Giacomo Guiulfo Knell"]
  spec.email = ["giaco@hey.com"]

  spec.summary = "An OmniAuth strategy for the Instagram API with Instagram Login"
  spec.description = "An OmniAuth strategy for the Instagram API with Instagram Login (https://developers.facebook.com/docs/instagram-platform/instagram-api-with-instagram-login)"
  spec.homepage = "https://github.com/giacomoguiulfo/omniauth-instagram-api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.require_paths = ["lib"]
  
  # spec.add_dependency "oauth2", "~> 2.0"
  spec.add_dependency 'omniauth', '~> 1'
  spec.add_dependency "omniauth-oauth2", "~> 1"
end
