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
        klass.load_deps
        prepare_config(klass)
        command = klass.new
        command.configure_chef
        command.run
      end

      def prepare_config(klass)
        klass.options.each do |key, preferences|
          if @current_resource.respond_to?(key)
            value = @current_resource.send(key)
            if preferences[:proc]
              preferences[:proc].call(value)
            else
              Chef::Config[:knife][key] = value
            end
          end
        end
      end
    end
  end
end