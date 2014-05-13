require 'knife/grinder'

class Chef
  class Knife
    class Grinder < Knife
      def run
        recipe = ARGV.last
        ARGV.clear
        ARGV << recipe
        Chef::Application::Apply.new.run
      end
    end
  end
end