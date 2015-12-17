module Wally    
  module Debug
    module Helper # to be included {Wally::Helper}
      #
      # Check, if **all** the requested debugging options are on.
      # @param [Symbol] what A debugging mask like `:signals`
      # @return [Boolean]
      def debugging?(what)
        mask = debug_masks[what]
        return false if mask.nil? 
        config.debugmask & mask == mask
      end

      # put debug notification onto the console.
      # @note only works for class instances!
      # @param [Symbol] what the symbolic logging level needed (:wip, :http)
      # @param [Array] arg Whatever can be joined :-)
      # @return [self]
      def debuginfo(what, *arg)
        log.debug "[#{classname}] "+arg.join("\n") if debugging?(what)
        return self
      end

      # do something, if debugging is on for this kind of debugging
      # @param [Symbol] what the debug level for this action
      # @yield [] reporting block
      # @return [Unknown] whatever the block returns
      def on_debug(what)
        if debugging?(what)
          yield
        end
      end

    end
  end
end


