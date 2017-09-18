module Backends
  module Dummy
    class Warehouse < ::Occi::Core::Warehouse
      class << self
        protected

        # :nodoc:
        def whereami
          __dir__
        end
      end
    end
  end
end
