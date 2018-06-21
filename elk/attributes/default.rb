 default['environment'] = "development"
 
default['java']['jdk_version']    = '8'
default['java']['install_flavor'] = 'openjdk'

default['elasticsearch']['version'] = '6.3.0'
default['kibana']['version'] = '6.3.0'
default['logstash']['version'] = '6.3.0'

default['elasticsearch']['cluster_name'] = "ts-elk-#{node['environment']}"

default['elasticsearch']['download_urls'] = {
  'debian'  => "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.deb",
  'rhel'    => "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.rpm",
  'tarball' => "https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-#{node['elasticsearch']['version']}.tar.gz",
}


default['kibana']['download_urls'] = {
  'debian'  => "https://artifacts.elastic.co/downloads/kibana/kibana-#{node['elasticsearch']['version']}-amd64.deb",
  'rhel'    => "https://artifacts.elastic.co/downloads/kibana/kibana-#{node['elasticsearch']['version']}-amd64.rpm",
  'tarball' => "https://artifacts.elastic.co/downloads/kibana/kibana-#{node['elasticsearch']['version']}-linux-x86_64.tar.gz",
}

default['logstash']['download_urls'] = {
  'debian'  => "https://artifacts.elastic.co/downloads/logstash/logstash-#{node['elasticsearch']['version']}.deb",
  'rhel'    => "https://artifacts.elastic.co/downloads/logstash/logstash-#{node['elasticsearch']['version']}.rpm",
  'tarball' => "https://artifacts.elastic.co/downloads/logstash/logstash-#{node['elasticsearch']['version']}.tar.gz",
}
