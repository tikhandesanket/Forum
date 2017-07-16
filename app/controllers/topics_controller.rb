class TopicsController < ApplicationController

  before_action :authenticate_user!

  def index
    @topics = Topic.includes(posts: :user)
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    binding.pry
    topic = current_user.topics.build(topic_params)
    if topic.save
      flash[:success] = "Topic created successfully."
      redirect_to topics_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def topic_params
    params.require(:topic).permit(:name, posts_attributes: [:id, :body, :user_id, :_destroy])
  end

end
