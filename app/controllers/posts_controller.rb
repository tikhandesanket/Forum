class PostsController < ApplicationController

  def index
    @posts = Post.includes(topic: :user)
  end

  def new
    @topic = Topic.find(params[:id])
    @post = @topic.posts.new
  end

  def create
    @topic = Topic.find(params[:post][:topic_id])
    post = @topic.posts.new(post_params)
    if post.save
      flash[:success] = "Post created successfully for topic #{@topic.name}"
      redirect_to topic_path(@topic.id)
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
  def post_params
    params.require(:post).permit(:body, :topic_id, :user_id)
  end

end
