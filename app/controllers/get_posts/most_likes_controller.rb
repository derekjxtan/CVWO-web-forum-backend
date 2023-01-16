class GetPosts::MostLikesController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /get_posts/most_likes
    def show
        @posts = Post.all.order('likes DESC, created_at DESC')

        render json: @posts, include: ["replies.user", "user"]
    end
end