source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails-controller-testing'
gem 'razorpay'
gem 'rubocop-rails', require: false
gem 'spree', '~> 4.3', github: 'spree/spree', branch: '4-3-stable'
gem 'spree_backend', '>= 4.3'
gem 'spree_frontend', '>= 4.3'

gemspec
