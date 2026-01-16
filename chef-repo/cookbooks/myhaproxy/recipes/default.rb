#
# Cookbook:: myhaproxy
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
# haproxy_install 'package'

# haproxy_forntend 'http-in' do
#     bind '*:80'
#     default_backend 'server_backend'
# end

# haproxy_install 'package'

# haproxy_frontend 'http-in' do
#     bind '*:80'
#     default_backend 'server_backend'
# end

# haproxy_backend 'server_backend' do
#     server [
#     'ec2-98-93-253-243.compute-1.amazonaws.com 98.93.253.243:80 maxconn 32',
#     'ec2-13-220-84-116.compute-1.amazonaws.com 13.220.84.116:80 maxconn 32'
#     ]
# end

# haproxy_service 'haproxy' do
#     action [ :enable, :start ]
# end

# haproxy_install 'package'

# haproxy_frontend 'http-in' do
#     bind '*:80'
#     default_backend 'server_backend'
# end

# web_nodes = search('node','policy_name:company_web')

# server_array = []

# web_nodes.each do |one_node|
#     one_server = "#{one_node['cloud']['public_hostname']} #{one_node['cloud']['public_ipv4']}:80 maxconn 32"
#     server_array.push(one_server)
# end

# haproxy_backend 'server_backend' do
#     server server_array
# end

# haproxy_service 'haproxy' do
#   action [ :enable, :start ]
# end


# Install HAProxy package on the node
haproxy_install 'package'

# Define a frontend called "http-in"
# This is where HAProxy listens for incoming client requests
haproxy_frontend 'http-in' do
    # Listen on all network interfaces (*) on port 80
    bind '*:80'

    # Send all incoming traffic to the backend named "server_backend"
    default_backend 'server_backend'
end

# Search the Chef Server for nodes that match this policy name
# In this case, it finds all web servers with policy_name = company_web
# web_nodes = search('node', 'policy_name:company_web')
web_nodes = search('node',"policy_name:company_web AND policy_group:#{node.policy_group}")

# Create an empty array to store backend server definitions
server_array = []

# Loop through each node returned by the search
web_nodes.each do |one_node|
    # Build a HAProxy server entry string
    # Format:
    # <server_name> <ip>:<port> <options>
    one_server = "#{one_node['cloud']['public_hostname']} #{one_node['cloud']['public_ipv4']}:80 maxconn 32"

    # Add this server entry into the server_array
    server_array.push(one_server)
end

# Define a backend called "server_backend"
# This backend contains all the web servers HAProxy will load balance to
haproxy_backend 'server_backend' do
    # Assign the dynamically generated list of servers
    server server_array
end

# Manage the HAProxy service
haproxy_service 'haproxy' do
  # Enable HAProxy to start on boot
  # Start the HAProxy service now
#   action [ :enable, :start ]
    subscribes :reload, 'template[/etc/haproxy/haproxy.cfg]', :delayed
end
