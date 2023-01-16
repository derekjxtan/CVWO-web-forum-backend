class GetPosts::NewestsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /get_posts/newest
    def show
        @posts = Post.all.order('created_at DESC')

        render json: @posts, include: ["replies.user", "user"]
    end
end