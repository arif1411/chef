#
# Cookbook:: myiis
# Recipe:: server
#
# Copyright:: 2022, The Authors, All Rights Reserved.

windows_feature 'IIS-WebServer' do
  action :install
  all true
end

template 'c:\inetpub\wwwroot\Default.htm' do
  source 'Default.htm.erb'
end

service 'w3svc' do
  action [:enable, :start]
end
