class Chef
  class Knife
    class Grinder < Knife
      def run
        Knife.run(['client', 'list'])
      end
    end
  end
end