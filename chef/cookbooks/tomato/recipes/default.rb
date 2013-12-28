include_recipe 'apt'

%w[curl gawk libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 autoconf libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev build-essential nodejs imagemagick].each do |pkg|
  package pkg
end

user "deploy" do
  comment "Deploy User"  
  gid "sudo"
  supports :manage_home => true # needed to actually create home dir
  home "/home/deploy"
  shell "/bin/bash"
  password '$1$VT/F5P.y$GuSLRwrDSiT2rArmstNQO1blahblah' 
end


package "openjdk-6-jdk"

include_recipe "nginx"
include_recipe "git"
include_recipe "mysql::server"
include_recipe "mysql"
include_recipe "database::mysql"

# create a mysql database
mysql_database 'tomato_production' do
  connection ({:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']})
  action :create
end
