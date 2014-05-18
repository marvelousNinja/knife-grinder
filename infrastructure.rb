machine 'my_very_first_node' do
  flavor 't1.micro'
  image 'ami-018c9568'
  ssh_user 'ubuntu'
  ssh_key_name 'infrastructure_key'
  action :create
end

machine 'my_very_first_node' do
  flavor 't1.micro'
  image 'ami-018c9568'
  ssh_user 'ubuntu'
  ssh_key_name 'infrastructure_key'
  purge true
  action :delete
end