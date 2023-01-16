class GetPostReplies::MostDislikesController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    def show
        @replies = Reply.where(:post_id => params[:post_id], reply_id: nil).order('dislikes DESC, created_at DESC')

        render json: @replies, include: ['user']
    end
end