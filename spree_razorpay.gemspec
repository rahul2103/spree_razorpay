lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift lib unless $LOAD_PATH.include?(lib)

require 'spree_razorpay/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_razorpay'
  s.version     = SpreeRazorpay.version
  s.summary     = 'Add extension summary here'
  s.description = 'Add (optional) extension description here'
  s.required_ruby_version = '>= 2.5'

  s.author    = 'Rahul Singh'
  s.email     = 'rahulsingh2103@yahoo.com'
  s.homepage  = 'https://github.com/rahul2103/spree_razorpay'
  s.license = 'BSD-3-Clause'

  s.files = `git ls-files`.split("\n").reject { |f| f.match(/^spec/) && !f.match(%r{^spec/fixtures}) }
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'razorpay'
  s.add_dependency 'spree', '= 4.3.2'
  s.add_dependency 'spree_backend', '= 4.3.2'
  s.add_dependency 'spree_extension'
  s.add_dependency 'spree_frontend', '= 4.3.2'

  s.add_development_dependency 'spree_dev_tools'
end
