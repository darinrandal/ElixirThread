module EventsHelper
	def dispatch_event(event)
		event_name = event_by_name(event.event_type)
		send("event_#{event_name}", event)
	end

private
	def event_by_name(id)
		events = ['unknown', 'register', 'permaban', 'unban', 'trash', 'untrash', 'usermod', 'edit']
		events[id]
	end

	def ago(event)
		time_ago_in_words(event.created_at) + ' ago'
	end

	def link_to_post(text, event)
		link_to(text, :controller => 'posts', :action => 'show', :id => event.post_id)
	end

	def link_to_p(e)
		link_to(e.primary_user.username, e.primary_user)
	end

	def link_to_s(e)
		link_to(e.secondary_user.username, e.secondary_user)
	end

	def event_unknown(event)
		'An unknown event occured ' + ago(event)
	end

	def event_register(event)
		link_to_p(event) + ' registered ' + ago(event)
	end

	def event_permaban(event)
		link_to_p(event) + ' permabanned ' + link_to_s(event) + ' for ' + link_to_post('this post', event) + ' ' + ago(event)
	end

	def event_unban(event)
		link_to_p(event) + ' unbanned ' + link_to_s(event) + ' ' + ago(event)
	end

	def event_trash(event)
		link_to_p(event) + ' trashed ' + link_to_s(event) + '\'s ' + link_to_post('post', event) + ' ' + ago(event)
	end

	def event_untrash(event)
		link_to_p(event) + ' untrashed ' + link_to_s(event) + '\'s ' + link_to_post('post', event) + ' ' + ago(event)
	end

	def event_usermod(event)
		link_to_p(event) + ' modified ' + link_to_s(event) + '\'s account information ' + ago(event)
	end

	def event_edit(event)
		link_to_p(event) + ' edited ' + link_to_s(event) + '\'s post ' + link_to_post('here', event) + ' ' + ago(event)
	end
end