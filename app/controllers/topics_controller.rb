class TopicsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_topic, only: [:show]

  def index
    @topics = Topic.includes(posts: :user)
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = current_user.topics.build(topic_params)
    if @topic.save
      flash[:success] = "Topic created successfully."
      redirect_to topics_path
    else
      flash[:alert] = "Something went wrong"
      @errors = @topic.errors.messages
      render :new
    end
  end

  def show
    @posts = @topic.posts
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

  def find_topic
    @topic = current_user.topics.friendly.find(params[:id])
    unless @topic.present?
      flash[:alert] = "Invalid Access"
      redirect_to topics_path
    end
  end

end
