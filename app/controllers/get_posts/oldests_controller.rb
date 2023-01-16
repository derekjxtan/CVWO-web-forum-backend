class GetPosts::OldestsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /get_posts/oldest
    def show
        @posts = Post.all.order('created_at ASC')

        render json: @posts, include: ["replies.user", "user"]
    end
end