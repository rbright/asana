require 'minitest/autorun'
require 'vcr'
require 'asana'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<API_KEY>') { ENV['ASANA_API_KEY'] }
end
