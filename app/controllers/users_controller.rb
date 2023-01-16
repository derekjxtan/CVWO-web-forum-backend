class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ index show create ]
  before_action :set_user, only: %i[ show update destroy ]

  # GET /users
  def index
    @users = User.all

    render json: @users, include: ["id", "username", "posts", "replies"]
  end

  # GET /users/1
  def show
    # check token for user. if user id matches query request then send everything. else just send posts and replies
    if request.headers['Authorization']
      header = request.headers['Authorization']
      header = header.split(' ').last
      begin
        @decoded = JwtToken.decode(header)
        if @decoded[:user_id] == @user.id
          render json: @user, include: ["id", "username", "posts.user", "replies.user", "liked.user", "disliked.user", "saved.user"]
        else
          render json: @user, include: ["id", "username", "posts.user", "replies.user"]
        end
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      rescue JWT::DecodeError => e
        render json: { errors: e.message }, status: :unauthorized
      end
    else
      render json:@user, include: ["id", "username", "posts.user", "replies.user"]
    end
    # render json: @user, include: ["id", "username", "posts.user", "replies.user"]
  end

  # POST /users
  def create
    @user = User.new(username: params[:username], password: params[:password])

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(username: params[:username], password: params[:password])
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
