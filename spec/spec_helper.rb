require 'simplecov'
require 'simplecov-rcov'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter[
                SimpleCov::Formatter::HTMLFormatter,
                SimpleCov::Formatter::RcovFormatter,
            ]
  add_filter "/spec/"
end

require 'timeout'
require "rspec"
require_relative "../lib/reek-checkstyle-formatter"

RSpec.configure do |config|
  config.color_enabled = true
end

require 'stringio'
# TODO if an error happens during capture everything is lost
def capture(stream_name)
  result = nil
  begin
    eval("$#{stream_name} = StringIO.new")
    yield
    result = eval("$#{stream_name}").string
  ensure
    eval("$#{stream_name} = #{stream_name.upcase}")
  end
  result
end
