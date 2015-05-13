require 'simplecov'
require 'simplecov-rcov'
require 'ci/reporter/rake/rspec_loader'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter
SimpleCov.start

load File.join(File.dirname(__FILE__),'..','lib','depptool.rb')

$-w=false # set it back here, elseway rspec gets strange warning(s).

# see logwatcher/spec for inspiration about further setup
#

