class Chef
  class Provider
    class Machine < Chef::Provider
      def load_current_resource
        @current_resource ||= Chef::Resource::Machine.new(new_resource.name)
        @current_resource.type(new_resource.type)
        @current_resource.image(new_resource.image)
        @current_resource
      end

      def action_create
        puts 'some crazy code here'
      end
    end
  end
end