#
# Cookbook:: graylog
# Recipe:: configure
#
# Copyright:: 2018, The Authors, All Rights Reserved.

this_instance = search("aws_opsworks_instance", "self:true").first

elasticsearch_nodes = []
search("aws_opsworks_instance", "role:es").each do |instance|
  elasticsearch_nodes.push(instance['private_ip'])
end

template '/etc/graylog/server/server.conf' do
  source 'server.conf.erb'
  owner 'root'
  group 'root'
  variables({
    elasticsearch_nodes: elasticsearch_nodes,
    my_ip: this_instance['private_ip']
  })
  notifies :restart, 'service[graylog-server]', :delayed
end

service 'graylog-server' do
  supports status: true
  action [:enable, :start]
end
