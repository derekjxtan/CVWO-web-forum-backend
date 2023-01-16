class GetSubReplies::OldestsController < ApplicationController
    skip_before_action :authenticate_user, only: %i[ show ]

    # GET /replies/#/get_sub_replies/newest
    def show
        @replies = Reply.where(:reply_id => params[:reply_id]).order('created_at ASC')

        render json: @replies, include: ['user']
    end
end