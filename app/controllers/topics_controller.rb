class TopicsController < ApplicationController

  before_action :authenticate_user!
  before_action :find_topic, only: [:show]

  def index
    if params[:tag].present?
      @topics = Topic.includes(posts: :user).tagged_with(params[:tag]).order('updated_at DESC').paginate(:page => params[:page], :per_page => 10)
    else
      @topics = Topic.includes(posts: :user).order('updated_at DESC').paginate(:page => params[:page], :per_page => 10)
    end
  end

  def new
    @topic = Topic.new
    @topic.posts.build
  end

  def create
    @topic = current_user.topics.build(topic_params)
    store_first_post_as_topic_body(@topic)
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

  def your_topics
    @your_topics = current_user.topics.includes(:posts, :tags).order('updated_at DESC').paginate(page: params[:page], per_page: 10)
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :tag_list, posts_attributes: [:id, :body, :user_id, :_destroy])
  end

  def find_topic
    @topic = current_user.topics.friendly.find(params[:id])
    unless @topic.present?
      flash[:alert] = "Invalid Access"
      redirect_to topics_path
    end
  end

  def store_first_post_as_topic_body(topic)
    unless topic.body.present?
      topic.body = topic.posts.first.body
    end
  end

end
