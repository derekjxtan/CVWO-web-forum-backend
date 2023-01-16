class Categories::OldestsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /categories/oldests/fun&action
    # if a category has '&' as part of it e.g.'1&2", it cannot be found since the 1 and 2 will be split
    # if any whitespaces in url, nothing will be returned.
    def show
        category = params[:id].split('&', -1)
        @posts = Post.where("categories @> ARRAY[?]::varchar[]", category).order('created_at ASC')
        render json: @posts, include: ["replies.user", "user"]
    end
end