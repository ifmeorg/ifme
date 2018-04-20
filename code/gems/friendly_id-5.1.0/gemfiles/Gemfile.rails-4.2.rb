source 'https://rubygems.org'

gemspec path: '../'

gem 'rails', '~> 4.2.0.rc3' do
  gem 'activerecord'
  gem 'railties'
end

gem 'i18n', '0.7.0.beta1'

# Database Configuration
group :development, :test do
  platforms :jruby do
    gem 'activerecord-jdbcsqlite3-adapter', '>= 1.3.0.beta2'
    gem 'activerecord-jdbcmysql-adapter', '>= 1.3.0.beta2'
    gem 'activerecord-jdbcpostgresql-adapter', '>= 1.3.0.beta2'
    gem 'kramdown'
  end

  platforms :ruby, :rbx do
    gem 'sqlite3'
    gem 'mysql2'
    gem 'pg'
    gem 'redcarpet'
  end

  platforms :rbx do
    gem 'rubysl', '~> 2.0'
    gem 'rubinius-developer_tools'
  end
end
