default['java']['jdk_version']    = '8'
default['java']['install_flavor'] = 'openjdk'

default['elasticsearch']['repo']['url'] = {
  "2.x" => "https://packages.elastic.co/elasticsearch/2.x/debian",
  "6.x" => "https://artifacts.elastic.co/packages/6.x/apt"
}
default['elasticsearch']['repo']['gpg'] = {
  "2.x" => "https://packages.elastic.co/GPG-KEY-elasticsearch",
  "6.x" => "https://artifacts.elastic.co/GPG-KEY-elasticsearch"
}

default['environment'] = "development"
default['elasticsearch']['version'] = "6.x"
default['elasticsearch']['cluster_name'] = "ts-#{node['environment']}"
