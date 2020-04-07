#
# Cookbook:: nodejsNginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
# apt_update 'update_sources' do
#   action :update
# end
apt_update 'update_sources' do
  action :update
end

package 'nginx'


service 'nginx' do
  action [:enable, :start]
end

template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

include_recipe 'nodejs'
package 'npm'
npm_package 'pm2'

npm_package 'react'
# node.default['nodejs']['install_method'] = 'binary'
# node.default['nodejs']['version'] = '8.12.2*'
# node.default['nodejs']['binary']['checksum'] = '99c4136cf61761fac5ac57f80544140a3793b63e00a65d4a0e528c9db328bf40'
# include_recipe "nodejs::npm"
# package nodejs do
#   version '8.12.2~dfsg-2ubuntu0.4'
# end
# npm_package 'pm2'
#
# npm_package 'react'
