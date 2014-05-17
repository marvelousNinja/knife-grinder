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
        Chef::Config[:knife][:image] = @current_resource.image
        Chef::Config[:knife][:flavor] = @current_resource.type
        Chef::Config[:knife][:ssh_user] = 'ubuntu'
        Chef::Config[:knife][:chef_node_name] = @current_resource.name

        Chef::Knife::Ec2ServerCreate.load_deps
        command = Chef::Knife::Ec2ServerCreate.new
        command.configure_chef
        command.run
      end

      def action_delete
        Chef::Config[:knife][:chef_node_name] = @current_resource.name
        Chef::Config[:knife][:purge] = true

        Chef::Knife::Ec2ServerDelete.load_deps
        command = Chef::Knife::Ec2ServerDelete.new
        command.configure_chef
        command.run
      end
    end
  end
end