require 'slack-notifier'

class IssueHook < Redmine::Hook::Listener
    def controller_issues_new_after_save(context)
        pingExecute context, l(:created_by)
    end

    def controller_issues_edit_after_save(context)
        pingExecute context, l(:updated_by)
    end

    def pingExecute(context,operation,attachment=nil)
        issue   = context[:issue]
		return if issue.is_private?

		url     = setSlackWebhookURL issue.project
		#channel = setSlackChannel issue.project

		#return unless url and channel and operation
		return unless url and operation

		attachment = {}
		attachment[:text] = issue.description if issue.description
		attachment[:fields] = [ {
			:title => I18n.t("field_priority"),
			:value => issue.priority.to_s,
			:short => true
		}, {
			:title => I18n.t("field_assigned_to"),
			:value => issue.assigned_to.to_s,
			:short => true
		}, {
			:title => I18n.t("field_status"),
			:value => issue.status.to_s,
			:short => true
		}]

        journal   = context[:journal]
        notes_url = obj_url(journal) if !journal.nil? && journal.notes.present?
        msg = "<#{obj_url issue}|[#{issue.project}]#{issue}>"+ (notes_url.blank? ? "" : " <#{notes_url}|[#{l(:with_notes)}]>") +"\n#{operation} #{issue.author}"

        notifier = Slack::Notifier.new url

        assigned_slackId = setUserSlackID User.find(issue.assigned_to.id)
        if (issue.assigned_to.id != User.current.id) && assigned_slackId.present?
            notifier.post text: "<@#{assigned_slackId}>\n" + msg, attachments: [attachment]
        else
            notifier.post text: msg, attachments: [attachment]
    end
end # class end

private
    def setSlackWebhookURL(prj) # from Project Custom Filed
        return nil if prj.blank?

        cf = ProjectCustomField.find_by_name("Slack Webhook URL")

        return [
            (prj.custom_value_for(cf).value rescue nil),
            (setSlackWebhookURL prj.parent),
        ].find{|v| v.present?}
    end

    # def setSlackChannel(prj) # from Project Custom Filed
    #     return nil if prj.blank?

    #     cf = ProjectCustomField.find_by_name("Slack Channel")

    #     val = [
    #         (prj.custom_value_for(cf).value rescue nil),
    #         (setSlackChannel prj.parent),
    #     ].find{|v| v.present?}

    #     return nil if val.to_s == '-'
    #     val
    # end

    def setUserSlackID(obj) # from Project Custom Filed
        return nil if obj.blank?

        cf = UserCustomField.find_by_name("Slack ID")

        return obj.custom_value_for(cf).value rescue nil
    end

	def obj_url(obj)
		if Setting.host_name.to_s =~ /\A(https?\:\/\/)?(.+?)(\:(\d+))?(\/.+)?\z/i
			host, port, prefix = $2, $4, $5
			Rails.application.routes.url_for(obj.event_url({
				:host => host,
				:protocol => Setting.protocol,
				:port => port,
				:script_name => prefix
			}))
		else
			Rails.application.routes.url_for(obj.event_url({
				:host => Setting.host_name,
				:protocol => Setting.protocol
			}))
		end
	end
end # private end
