require 'spec_helper'

listen_port = 80

#---------------------------------------------------------------#
# Package installation check
#---------------------------------------------------------------#
# MySQL client
describe package('mysql-community-client') do
  it { should be_installed }
end

# Ruby
describe command('ruby -v') do
  its(:stdout) { should match /3.2.3/ }
end

# Bundler
describe package('bundler') do
  it { should be_installed.by('gem').with_version('2.3.14') }
end

# Rails
describe package('rails') do
  it { should be_installed.by('gem').with_version('7.1.3.2') }
end

# Nginx
describe package('nginx') do
  it { should be_installed }
end

# Node.js
describe command('node -v') do
  its(:stdout) { should match /v17.9.1/ }
end

# yarn
describe command('yarn -v') do
  its(:stdout) { should match /1.22.19/ }
end

#---------------------------------------------------------------#
# File exsitence check
#---------------------------------------------------------------#
# puma.service
describe file('/etc/systemd/system/puma.service') do
  it { should exist }
end

#---------------------------------------------------------------#
# Service status check
#---------------------------------------------------------------#
# Puma
describe service('puma.service') do
  it { should be_enabled }
  it { should be_running }
end

# Nginx
describe service('nginx.service') do
  it { should be_enabled }
  it { should be_running }
end

#---------------------------------------------------------------#
# Port status check
#---------------------------------------------------------------#
# listen port
describe port(listen_port) do
  it { should be_listening }
end

#---------------------------------------------------------------#
# Connection check
#---------------------------------------------------------------#
# Local loopback address
describe command('curl http://127.0.0.1:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

# DNS name
describe command('curl http://manual-deploy-alb-269116932.ap-northeast-1.elb.amazonaws.com:#{listen_port}/_plugin/head/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^200$/ }
end

