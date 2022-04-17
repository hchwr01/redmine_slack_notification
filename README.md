# redmine_slack_notification

## Japanese followed by English

当プラグインは [redmine_slack](https://github.com/sciyoshi/redmine-slack) を参考にし、[slack-notifier](https://github.com/slack-notifier/slack-notifier) を用いて作成されています。  
両制作者に心より感謝いたします。  

## インストール
プラグインルートディレクトリにクローンします。
```
e.g.) git clone https://github.com/hchwr01/redmine_slack_notification.git redmine_slack_notification
```

必要に応じて所有権とグループを変更します。
```
e.g.) chown -R apache:apache redmine_slack_notification/
```

プラグインディレクトリで `slack-notifier` をインストールしてください。
```
e.g.) bundle install
```

Redmine もしくは Apache の再起動が必要です。
```
e.g.) systemctl restart httpd
```

## 使い方
事前に Slack Incoming Webhooks(App) を 登録し、Wehook URL を取得してください。  
Slack Incoming Webhooks(App) はチャンネル指定必須です。
```
https://api.slack.com/
```

下記の名称でテキスト形式のプロジェクトカスタムフィールドを追加し、取得した Wehook URL を保存してください。
```
Slack Webhook URL
```

下記の名称でテキスト形式のユーザーカスタムフィールドを追加し、あなたの Slack でのメンバーIDを保存してください。
```
Slack ID
```

## 条件
1. Slack Webhook URL が保存されていること
2. 課題がプライベートではないこと
3. 課題作成、更新問わず通知される

## メンションについて
課題担当者と更新者が同じ場合、通知は行われますがメンションは付きません。  
課題担当者と更新者が別の場合、通知とメンションが行われます。

## 今後の予定
* メンション有無を設定できるようにする
* 課題作成、更新で通知有無を設定できるようにする
* Wiki作成、更新で通知有無を設定できるようにする
* コメントメンションに対応する(Redmine Ver5)
---
This plugin is based on [redmine_slack](https://github.com/sciyoshi/redmine-slack) and [slack-notifier](https://github.com/slack-notifier/slack- notifier).  
Our sincere thanks to both creators.

## Installation
Clone to the plugin root directory.
```
e.g.) git clone https://github.com/hchwr01/redmine_slack_notification.git redmine_slack_notification
```
Change ownership and groups as needed.
```
e.g.) chown -R apache:apache redmine_slack_notification/
```
Install `slack-notifier` in the plugin directory.
```
e.g.) bundle install
```
Redmine or Apache must be restarted.
```
e.g.) systemctl restart httpd
```
## Usage
Please register Slack Incoming Webhooks(App) in advance and obtain the Wehook URL.  
Slack Incoming Webhooks(App) requires channel designation.
```
https://api.slack.com/
```

Add a project custom field in text format with the following name and save the retrieved Wehook URL.
```
Slack Webhook URL
```

Add a user custom field in text format with the following name and save your member ID in Slack.
```
Slack ID
```
## Conditions
1. the Slack Webhook URL must be saved
2. the issue is not private
3. Notification whether the issue is created or updated

## About Mentions
* If the person in charge of the issue and the person who updated the issue are the same, the issue will be notified but no mentions will be made.  
* If the assignee and the updater are different, notifications and mentions will be sent.

## Future plans
* Make it possible to set whether or not to have mentions
* Enable to set whether or not to be notified when creating or updating issues
* Enable notification/notification for wiki creation and update.
* Support comment mentions (Redmine Ver5)

## *Translated with www.DeepL.com/Translator (free version)*