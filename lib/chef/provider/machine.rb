class Chef
  class Provider
    class Machine < Chef::Provider
      def load_current_resource
        @current_resource = new_resource
      end

      def whyrun_supported?
        true
      end

      def action_create
        if machine_exists?
          Chef::Log.info "#{current_resource} already exists."
        else
          converge_by("Creating #{current_resource}") do
            run_command(Chef::Knife::Ec2ServerCreate)
          end
        end
      end

      def action_delete
        if machine_exists?
          converge_by "Deleting #{current_resource}" do
            run_command(Chef::Knife::Ec2ServerDelete)
          end
        else
          Chef::Log.info "#{current_resource} does not exist."
        end
      end

      private

      def machine_exists?
        node = query.search(:node, "name:#{current_resource.name}").first
        if node.empty? && current_resource.retries > 0
          raise Chef::Exceptions::SearchIndex("Node not found: #{current_resource.name}")
        end
        !node.empty?
      end

      def query
        Chef::Search::Query.new
      end

      def run_command(klass)
        klass.load_deps
        prepare_config(klass)
        command = klass.new
        command.configure_chef
        command.run
      end

      def prepare_config(klass)
        klass.options.each do |key, preferences|
          if current_resource.respond_to?(key)
            value = current_resource.send(key)
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