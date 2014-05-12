require 'chef/resource'

class Chef
  class Resource
    class Machine < Chef::Resource
      def initialize(run_context = nil)
        super # not sure how to test it
        @resource_name = :machine
        @provider = nil
        @action = :create
        @allowed_actions = [:create]
      end
    end
  end
end