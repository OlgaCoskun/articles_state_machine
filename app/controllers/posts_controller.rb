class PostsController < ApplicationController
  before_action :set_post, only: [:send_to_publish, :send_to_moderator, :show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
  end

  def moderator
    @posts = Post.all
  end

  def all
    @posts = Post.all
  end

  def send_to_moderator
    @post.send_to_moderation
    redirect_to moderator_posts_path, notice: 'Your post has been sent to moderator' if @post.save
  end

  def send_to_publish
    @post.send_to_published
    if @post.state == 'published'
      redirect_to root_path, notice: 'Пост выставлен'
    else
      redirect_to post_path(@post), notice: 'Нужен линк и категория'
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    # @post.build_category
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render :new
    end

    render json: { text: "Some message you want to include" }
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    defaults = { state: 'created' }
    params.fetch(:post, {}).permit(:title, :body, :link, :category_id).reverse_merge(defaults)
  end
end

