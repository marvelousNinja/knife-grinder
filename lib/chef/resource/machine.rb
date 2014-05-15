class Chef
  class Resource
    class Machine < Chef::Resource
      def initialize(name, run_context = nil)
        super
        @resource_name = :machine
        @provider = Chef::Provider::Machine
        @action = :create
        @allowed_actions = [:create]
      end

      def type(arg = nil)
        set_or_return(:type, arg, {
          :required => true,
          :kind_of => String, 
          :equal_to => machine_types,
          :default => machine_types.first
        })
      end

      def image(arg=nil)
        set_or_return(:image, arg, {
          :required => false,
          :kind_of => String
        })
      end

      def machine_types
        ['t1.micro']
      end
    end
  end
end