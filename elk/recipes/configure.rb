#
# Cookbook:: elk
# Recipe:: configure
#
# Copyright:: 2018, The Authors, All Rights Reserved.

this_instance = search("aws_opsworks_instance", "self:true").first
layer_id      = this_instance["layer_ids"][0]
elasticsearch_nodes = []
search("aws_opsworks_instance", "layer_ids:#{layer_id}").each do |instance|
  elasticsearch_nodes.push(instance['private_ip'])
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner 'root'
  group 'elasticsearch'
  mode '0744'
  variables({
    elasticsearch_nodes: elasticsearch_nodes,
    node_name: 	this_instance["hostname"],
    my_ip: this_instance['private_ip'],
    rack_id: this_instance["availability_zone"]
  })
  notifies :restart, 'service[elasticsearch]', :delayed
end

template '/etc/kibana/kibana.yml' do
  source 'kibana.yml.erb'
  owner 'kibana'
  group 'kibana'
  mode '0744'
  variables({
    elasticsearch_nodes: elasticsearch_nodes,
    node_name: 	this_instance["hostname"],
    my_ip: this_instance['private_ip'],
    rack_id: this_instance["availability_zone"]
  })
  notifies :restart, 'service[kibana]', :delayed
end

service 'elasticsearch' do
  supports status: true
  action [:enable, :start]
end

service 'kibana' do
  supports status: true
  action [:enable, :start]
end
