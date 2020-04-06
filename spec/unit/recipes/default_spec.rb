#
# Cookbook:: nodejsNginx
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'nodejsNginx::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
    # installing
      # install Nginx
      # install nodejs
    it 'runs apt get update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    #install nginx
    it 'should install nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    # install node js
    # git this to be installed from dependency
    it 'should install nodejs' do
      expect(chef_run).to install_package 'nodejs'
    end
    # Services
    # Nginx
    it 'should enable nginx' do
      expect(chef_run).to enable_service 'nginx'
    end

    it 'should start nginx' do
      expect(chef_run).to start_service 'nginx'
    end

    # if we create a new proxy.config file for Nginx
    it 'should create a proxy.conf template in /etc/nginx/sites-available/' do
      expect(chef_run).to create_template "/etc/nginx/sites-available/proxy.conf"
    end

    it 'should link a proxy.conf to sites enabled' do
      expect(chef_run).to create_link("/etc/nginx/sites-enabled/proxy.conf").with_link_type(:symbolic)
    end

    it 'should link a proxy.conf to sites enabled' do
      expect(chef_run).to delete_link("/etc/nginx/sites-enabled/default")
    end
  end
end
