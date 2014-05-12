require 'chef/provider'

class Chef
  class Provider
    class Machine < Chef::Provider
      def load_current_resource
        @current_resource ||= Chef::Resource::Machine.new(new_resource.name)
        @current_resource.free(new_resource.free)
        @current_resource
      end

      def action_create

      end
    end
  end
end