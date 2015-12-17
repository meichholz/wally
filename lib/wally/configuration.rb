module Wally

  # {Options} holds a hash containing all configuration values.
  # This shim class allows to register and delegate all the accessor methods
  # without interfering too much with builtin methods.
  class Options # no base class, no methods that can cause trouble
    attr_accessor :store
    def self.write_accessors_for(name)
      eval "def #{name}\n @store[:#{name}]\n end\n"
      eval "def #{name}=(v)\n @store[:#{name}]=v\n end\n"
    end
    def initialize
      @store = Hash.new
    end
  end

  # all shared state is hosted in this class object.
  # it simply hosts and initializes an open struct {opt}
  #
  # This class is free from policy or application details.
  # Someone has to complete the setup at run time:
  #
  # @example
  #   Configuration.use_preset @some_default_hash
  #   Configuration.read [ '/etc/app.conf', '~/.app.conf' ]
  class Configuration < BaseObject

    # ok, where to house this? At least, here is application specific stuff.
    # do not use directly

    class << self

      attr_reader :opt
  
      # @fixme Really dirty hack
      # deferred instantiation of this module. Will be done by module loading.
      def init
        Options.init
      end
      def configure
        yield @opt
      end
      def read(filenames)
        filenames.each do |filename|
          begin
            if File.exists? filename
              verbalize "reading configuration from #{filename}"
              code = File.read(filename)
              eval code
            else
              log.warn "no config file at `#{filename}'"
            end
          rescue => err
            panic "error in config file `#{filename}': #{err}"
          end
        end
      end

      # Integrate (set or override) additionals options from the command line.
      # The tokens are added as needed.
      #
      # @param [Hash] from the options from the command line interpretation
      def set_options(from)
        from.each_pair do |var, preset|
          @opt.store[var] = preset
          @opt.class.write_accessors_for var unless @opt.respond_to? var
        end
      end
    end

    @opt = Options.new
  end

end


