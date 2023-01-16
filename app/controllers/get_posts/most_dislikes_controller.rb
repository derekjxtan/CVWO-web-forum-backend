class GetPosts::MostDislikesController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /get_posts/most_dislikes
    def show
        @posts = Post.all.order('dislikes DESC, created_at DESC')

        render json: @posts, include: ["replies.user", "user"]
    end
end