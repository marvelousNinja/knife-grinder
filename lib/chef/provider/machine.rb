class Chef
  class Provider
    class Machine < Chef::Provider
      def load_current_resource
        @current_resource ||= new_resource
      end

      def action_create
        run_command(Chef::Knife::Ec2ServerCreate)
      end

      def action_delete
        run_command(Chef::Knife::Ec2ServerDelete)
      end

      private

      def run_command(klass)
        prepare_config(klass)
        klass.load_deps
        command = klass.new
        command.configure_chef
        command.run
      end

      def prepare_config(klass)
        klass.options.each_key do |key|
          if @current_resource.respond_to?(key)
            Chef::Config[:knife][key] = @current_resource.send(key)
          end
        end
      end
    end
  end
end