class PostsController < ApplicationController
  before_action :authenticate_user!, only:[:create, :edit, :update, :new]
  before_action :find_topic, only:[:new, :create, :index]
  def index
    @posts = @topic.posts.includes(:user).order('updated_at DESC').paginate(page: params[:page], per_page: 10)
    @new_post = @topic.posts.new
  end

  def new
    @post = @topic.posts.new
  end

  def create
    @post = @topic.posts.new(post_params)
    @posts = @topic.posts.includes(:user).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    if @post.save
      respond_to do |format|
        format.html {
          flash[:success] = "Post created successfully for topic #{@topic.name}"
          redirect_to topic_path(@topic.slug)
        }
        format.js {flash[:success] = "Post created successfully for topic #{@topic.name}"}
      end
    else
      @errors = @post.errors.messages
      respond_to do |format|
        format.html {
          flash[:alert] = "Something went wrong"
          render :new
        }
        format.js {}
      end
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

  def leave_comment
  end

  private
  def post_params
    params.require(:post).permit(:body, :topic_id, :user_id)
  end

  def find_topic
    @topic = Topic.friendly.find(params[:topic_id])
    unless @topic.present?
      flash[:alert] = "Invalid Access"
      redirect_to topics_path
    end
  end

end
