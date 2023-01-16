class ReplyDislikesController < ApplicationController
    before_action :set_like, only: %i[ create ]
    before_action :set_dislike, only: %i[ destroy ]
    before_action :set_reply, only: %i[ create destroy ] 

    # POST /dislike
    # Check database for existing dislike. Delete existing like if any. Create new dislike and update counts on post 
    def create
        if !dislike_exist
            if like_exist
                @like.destroy
            end

            @dislike = DislikedReply.create(user_id: @current_user.id, reply_id: @reply.id)

            dislike_count = DislikedReply.where(reply_id: @reply.id).count
            like_count = LikedReply.where(reply_id: @reply.id).count

            @reply.update(likes: like_count, dislikes: dislike_count)
            
            render json: @reply
        end
    end

    # DELETE /dislike
    # Check database for existing dislike and delete if there is. Update count on post
    def destroy
        if dislike_exist
            @dislike.destroy
            dislike_count = DislikedReply.where(reply_id: @reply.id).count
            @reply.update(dislikes: dislike_count)
            render json: @reply
        end
    end

    private
        # checks whether there is an existing LikedReply entry with the given userid and replyid
        def like_exist
            LikedReply.where(user_id: @current_user.id, reply_id: params[:reply_id]).exists?
        end

        # checks whether there is an existing DislikedReply entry with the given userid and replyid
        def dislike_exist
            DislikedReply.where(user_id: @current_user.id, reply_id: params[:reply_id]).exists?
        end

        # sets @like to the found entry in LikedReply with given userid and replyid
        def set_like
            @like = LikedReply.find_by(user_id: @current_user.id, reply_id: params[:reply_id])
        end

        # sets @dislike to the found entry in DislikedReply with given userid and replyid
        def set_dislike
            @dislike = DislikedReply.find_by(user_id: @current_user.id, reply_id: params[:reply_id])
        end

        # sets @reply to the entry in Reply with given replyid
        def set_reply
            @reply = Reply.find(params[:reply_id]);
        end
end