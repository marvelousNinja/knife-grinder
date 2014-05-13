require 'chef/application/solo'

class Chef
  class Knife
    class Grinder < Knife
      def run
        ARGV.clear
        ARGV << ["-c", "/home/alex/work/diploma/chef-repo/solo.rb", "--override-runlist", "recipe[sample]"]
        Chef::Application::Solo.new.run
        # Chef::Config[:config_file] = '/home/alex/work/diploma/chef-repo/solo.rb'
        # #Chef::Config[:cookbook_path] = '/home/alex/work/diploma/chef-repo/cookbooks'
        # Chef::Config[:override_runlist] = [Chef::RunList::RunListItem.new('recipe[sample]')]
      end
    end
  end
end