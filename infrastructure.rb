machine 'my_very_first_node' do
  infrastructure 'ec2'
  flavor 't1.micro'
  image 'ami-018c9568'
  ssh_user 'ubuntu'
  ssh_key_name 'infrastructure_key'
  action [:create, :delete]

  retries 2
  retry_delay 20
end