class Chef
  class Resource
    class Machine < Chef::Resource      
      def initialize(name, run_context = nil)
        super
        @resource_name = :machine
        @provider = Chef::Provider::Machine
        @action = :create
        @allowed_actions = [:create, :delete]

        @chef_node_name = name
      end

      def chef_node_name(arg = nil)
        set_or_return(:chef_node_name, arg, {
          :required => true,
          :kind_of => String,
          :name_attribute => true
        })
      end

      def infrastructure(arg = nil)
        set_or_return(:infrastructure, arg, {
          :required => true,
          :kind_of => String
        })
      end

      private
      def method_missing(name, *args, &block)
        if args.count == 1
          eigenclass = class << self; self; end
          eigenclass.class_eval do
            define_method(name) do |arg = nil|
              set_or_return(name, arg, {})
            end
          end
          return send(name, *args, &block)
        end
        super
      end
    end
  end
end