require 'chef/resource'

class Chef
  class Resource
    class Machine < Chef::Resource
      def initialize(name, run_context = nil)
        super # not sure how to test it
        @resource_name = :machine
        @provider = Chef::Provider::Machine
        @action = :create
        @allowed_actions = [:create]

        @free = true # i.e. micro instance :)
      end

      def free(arg = nil)
        set_or_return(:free, arg, :kind_of => [TrueClass, FalseClass])
      end
    end
  end
end