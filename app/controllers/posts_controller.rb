class PostsController < ApplicationController
  before_action :find_topic, only:[:new, :create]
  def index
    @posts = Post.includes(topic: :user)
  end

  def new
    @post = @topic.posts.new
  end

  def create
    @post = @topic.posts.new(post_params)
    if @post.save
      flash[:success] = "Post created successfully for topic #{@topic.name}"
      redirect_to topic_path(@topic.slug)
    else
      @errors = @post.errors.messages
      flash[:alert] = "Something went wrong"
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
  def post_params
    params.require(:post).permit(:body, :topic_id, :user_id)
  end

  def find_topic
    @topic = current_user.topics.friendly.find(params[:topic_id])
    unless @topic.present?
      flash[:alert] = "Invalid Access"
      redirect_to topics_path
    end
  end

end
