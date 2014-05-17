machine 'my_very_first_node' do
  flavor 't1.micro'
  image 'ami-018c9568'
  ssh_user 'ubuntu'
  action :create
end