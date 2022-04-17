require 'redmine'
require_dependency File.expand_path('../lib/issue_hook', __FILE__)

Redmine::Plugin.register :redmine_slack_notification do
  name 'Redmine Slack Notification plugin'
  author 'hchwr01'
  description 'Notification from Redmine to Slack Incoming Webhooks(App)'
  version '0.0.1'
  url 'https://github.com/hchwr01/redmine_slack_notification.git'
  author_url 'https://hachiware-eng.com'
end
