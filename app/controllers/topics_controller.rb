class TopicsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

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
    if @topic.save
      flash[:success] = "Topic created successfully."
      redirect_to topic_posts_path(@topic.slug)
    else
      flash[:alert] = "Something went wrong"
      @errors = @topic.errors.messages
      render :new
    end
  end

  def show
  end

  def edit
    @topic = current_user.topics.friendly.find(params[:id])
  end

  def update
    @topic = current_user.topics.friendly.find(params[:id])
    if @topic.update_attributes(topic_params)
      redirect_to topic_posts_path(@topic.slug)
    else
      render :edit
    end
  end

  def destroy
  end

  def your_topics
    @your_topics = current_user.topics.includes(:posts, :tags).order('updated_at DESC').paginate(page: params[:page], per_page: 10)
  end

  private
  def topic_params
    params.require(:topic).permit(:name, :body, :tag_list)
  end
end
