this_instance = search("aws_opsworks_instance", "self:true").first
layer_id      = this_instance["layer_ids"][0]
elasticsearch_nodes = []
search("aws_opsworks_instance", "layer_ids:#{layer_id}").each do |instance|
  elasticsearch_nodes.push(instance['private_ip'])
end
master_nodes_quorum = (search("aws_opsworks_instance", "layer_ids:#{layer_id}").size / 2) + 1

if node['elasticsearch']['version'] == "6.x" then
  template '/etc/elasticsearch/elasticsearch.yml' do
    source 'elasticsearch.yml.erb'
    owner 'root'
    group 'elasticsearch'
    mode '0744'
    variables({
      elasticsearch_nodes: elasticsearch_nodes,
      master_nodes_quorum: master_nodes_quorum,
      node_name: 	this_instance["hostname"],
      node_rack: "node.attr.rack_id",
      rack_id: this_instance["availability_zone"]
    })
    notifies :restart, 'service[elasticsearch]', :delayed
  end
else
  template '/etc/elasticsearch/elasticsearch.yml' do
    source 'elasticsearch.yml.erb'
    owner 'root'
    group 'elasticsearch'
    mode '0744'
    variables({
      elasticsearch_nodes: elasticsearch_nodes,
      master_nodes_quorum: master_nodes_quorum,
      node_name: 	this_instance["hostname"],
      node_rack: "node.rack_id",
      rack_id: this_instance["availability_zone"],
      xpack: "xpack.license.self_generated.type: basic"
    })
    notifies :restart, 'service[elasticsearch]', :delayed
  end
end

service 'elasticsearch' do
  supports status: true
  action [:enable, :start]
end
