require 'gli'
require 'tk'
require 'logger'
require 'colorize'

@base_modnames = [ 'debug', 'helper', 'baseobject', ]

def init_loader
  # static framework
  @debug_autoload = ENV['DEBUG_AUTOLOAD']
  @module_path = File.join(File.dirname(__FILE__), File.basename(__FILE__, '.rb'))
end

def load_basemodules
  STDERR.printf "==> preloading modules: " if @debug_autoload
  @base_modules = @base_modnames.collect {|f| File.join(@module_path, f.to_s+'.rb')}
  @base_modules.each do |file|
    STDERR.printf "%s, ", File.basename(file,'.rb') if @debug_autoload
    load file
  end
end

def load_modules
  allmodules = Dir.glob(File.join(@module_path, '**.rb'))
  (allmodules-@base_modules).each do |file|
    STDERR.printf "%s, ", File.basename(file,'.rb') if @debug_autoload
    load file
  end
  STDERR.puts "done." if @debug_autoload
end

# now load everything You need and mix in the project name space
init_loader
load_basemodules
# include Wally # @think can be someway factored out
load_modules

