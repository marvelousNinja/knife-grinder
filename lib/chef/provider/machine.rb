require 'pry'

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
        converge_by("Creating #{current_resource}") { run } unless machine_exists?
      end

      def action_delete
        raise Chef::Exceptions::ResourceNotFound unless machine_exists? || current_resource.retries == 0 
        converge_by("Deleting #{current_resource}") { run }
      end

      private

      def machine_exists?
        find_machine(current_resource.name).first
      end

      def find_machine(name)
        query.search(:node, "name:#{name}").first
      end

      def query
        Chef::Search::Query.new
      end

      def run
        klass = derive_command_class
        klass.load_deps
        prepare_config(klass)
        command = klass.new
        command.configure_chef
        command.run
      end

      def derive_command_class
        action = self.action
        infrastructure = current_resource.infrastructure
        require "chef/knife/#{infrastructure}_server_#{action}"
        Kernel.const_get "Chef::Knife::#{infrastructure.capitalize}Server#{action.capitalize}"
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