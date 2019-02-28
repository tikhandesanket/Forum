class DashboardsController < ApplicationController

	before_action :authenticate_user!, only:[:basic_info]

	def index
    @recent_topics = Topic.order('created_at desc').paginate(:page => params[:page], :per_page => 10)
	end

	def basic_info

	end
end
