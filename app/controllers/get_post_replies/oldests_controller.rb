class GetPostReplies::OldestsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    def show
        @replies = Reply.where(:post_id => params[:post_id], reply_id: nil).order('created_at ASC')

        render json: @replies, include: ['user']
    end
end