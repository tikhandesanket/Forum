module TopicsHelper
	def is_current_user_topic(user_id, topic_user_id)
		return	user_id == topic_user_id
	end
end
