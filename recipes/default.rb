#
# Cookbook:: nodejsNginx
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.
apt_update 'update_sources' do
  action :update
end
package 'nginx'
package 'nodejs'


service 'nginx' do
  action [:enable, :start]
end

template "/etc/nginx/sites-available/proxy.conf" do
  source 'proxy.conf.erb'
end

link '/etc/nginx/sites-enabled/default' do
  action :delete
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available'
  notifies :restart, 'service[nginx]'
end


describe package('nodejs') do
  it { should be_installed }
  its('version') { should cmp > '8.11.2*' }
end

describe npme('pm2') do
  it {shoudl be_installed }
end

describe npm('react') do
  it { should be_installed }
end
