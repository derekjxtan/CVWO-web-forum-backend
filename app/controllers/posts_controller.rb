class PostsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ index show ]
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.all

    render json: @posts, include: ["replies.user", "user"]
  end

  # GET /posts/1
  def show
    render json: @post, include: ["replies.user", "user"]
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.user_id != @current_user.id
      render json: @post.errors, status: :unauthorized
    elsif @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    if @post.user_id == @current_user.id
      @post.destroy
    else
      render json: @post.errors, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :user_id, :categories => [])
    end
end
