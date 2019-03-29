module PostsHelper
	def post_count(topic)
		return topic.posts.count - 1 #-1 for first post
	end

	def is_comments_avail(topic)
		return ((topic.posts.count.to_i - 1) == 0)
	end
end
