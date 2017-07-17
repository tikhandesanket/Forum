class DashboardsController < ApplicationController
	def index
    @recent_topics = Topic.order('created_at desc').first(10)
	end
end
