# @alltodos

# This is the **global** infrastructure module, meant to be **loaded first**.
#
# At heart, it es a reflector for politics implemented by, say, {App}, to allow
# for **low ceremony**, refactoring, and re-use.
#
# This is the **top module**, mixed in by everyone, and providing basically just the "mixer" method `include_helpers`.
# The *real* frameworking interface is {Wally::Helper}.
#
# @example
#     include Wally
#     class Foo
#       load_helpers
#     end
#

module Wally

  NAME = 'wally'

  # @example Canonical usage of the Helper module
  #   module Wally
  #     class BaseObject
  #       load_helpers
  #       # .. off we go ..
  #     end
  #   end
  # @note Practically, just derive from {Wally::BaseObject} and You are done.
  # just mix in all this nice stuff.
  # @return [Void]
  def include_helpers
    include Wally::Helper::SharedMethods
    include Wally::Helper::InstanceMethods # this will extend the class itself
  end

  # Here we bundle everything needed at hand globally (aka "frameworky" stuff).
  #
  # This is an *interface*, delegating to (mostly) {App} services implementing
  # the real action.
  # It is mixed in by {include_helpers}.
  #
  # * access to configuration etc.
  # * access to debugging facilities (see {Wally::Debug})
  # * access to logging, panic exiting, verbosing
  module Helper

    module InstanceMethods
      # the callback, triggering extension of the class itself
      # @return [Void]
      def self.included(up_module)
        up_module.extend Wally::Helper::SharedMethods
        up_module.extend Wally::Helper::ClassMethods
      end

      # @see Wally::Helper::ClassMethods::_classname
      def classname
        return self.class.classname
      end
    end

    module ClassMethods
      # @return [String] downcased class name without outer module
      def classname
        return self.to_s.gsub(/^Wally::/,"").downcase
      end
    end

    module SharedMethods
      include Wally::Debug::Helper # needs Wally::Debug#boot called
      # @see Wally::Configuration.opt
      def config
        Wally::Configuration.opt
      end
      # get available debugging masks
      # @return [Hash<Symbol,Integer>]
      def debug_masks
        Wally::App.debug_masks
      end
      # get the API base URL according to the environment setting.
      # @return [String] API base URL
      def api_base_url
        config.apis[config.environment]
      end

      # get the facility to `puts()` to for the current instance
      # @return [Logger]
      def log
        Wally::App.logger
      end

      # Panic or raise an exception for a yet unknown function, leading to the
      # calling object.
      # @return [void]
      def not_implemented_yet
        raise "method is not implemented yet in `#{classname}'"
      end
      # put a last warning onto the console and exit.
      # @param [Array] arg Whatever can be joined :-)
      # @return [void]
      def panic(*arg)
        log.fatal arg.join("\n")+" (#{NAME} aborted by `#{classname}'])"
        exit 1
      end

      # put some notification onto the console or the logger, if there is one
      # @param [Array] arg Whatever can be joined :-)
      # @return [self]
      def verbalize(*arg)
        log.info "#"+arg.join("\n") if config.verbose
        return self
      end

    end
  end

end unless defined? Wally::NAME

