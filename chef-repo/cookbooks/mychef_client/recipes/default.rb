#
# Cookbook:: mychef_client
# Recipe:: default
#
# Copyright:: 2026, The Authors, All Rights Reserved.
if platform?('windows')
    chef_client_scheduled_task 'Run as a scheduled task'
 else
    chef_client_cron 'Run as a cron job'
 end
 