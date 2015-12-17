# need the extension part, will be bootstrapped
include Wally # just needed for bootstrapping
module Wally  
  # Barebones base class that includes the complete helper stuff by itself.
  # @example Simplified usage of helper infrastructure
  #   module Wally
  #     class Foo < BaseObject
  #     end
  #   end
  #
  class BaseObject
    include_helpers
  end
end

