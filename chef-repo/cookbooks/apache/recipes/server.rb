#
# Cookbook:: apache
# Recipe:: server
#
# Copyright:: 2026, The Authors, All Rights Reserved.
package 'httpd'

# file '/var/www/html/index.html' do
#   content "<h1>Hello, world!</h1> 
#       <h2>PLATFORM; <%= node['platform'] %></h2>
#       <h2>PLATFORM; <%= node['hostname'] %></h2>
#       <h2>PLATFORM; <%= node['memory']['total'] %></h2>
#       <h2>PLATFORM; <%= node['cpu']['0']['mhz'] %></h2>"
# end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

service 'httpd' do
  action [:enable, :start]
end
