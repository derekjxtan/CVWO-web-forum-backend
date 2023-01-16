class ReplyLikesController < ApplicationController
    before_action :set_dislike, only: %i[ create ]
    before_action :set_like, only: %i[ destroy ]
    before_action :set_reply, only: %i[ create destroy ] 

    # # POST /like
    # # Check database for existing like. Delete existing dislike if any. Create new like and update counts on post 
    def create
        if !like_exist
            if dislike_exist
                @dislike.destroy
            end

            @like = LikedReply.create(user_id: @current_user.id, reply_id: @reply.id)

            like_count = LikedReply.where(reply_id: @reply.id).count
            dislike_count = DislikedReply.where(reply_id: @reply.id).count

            @reply.update(likes: like_count, dislikes: dislike_count)

            render json: @reply
        else
            render json: {}
        end
    end

    # # DELETE /like
    # # Check database for existing like and delete if there is. Update count on post
    def destroy
        if like_exist
            @like.destroy
            like_count = LikedReply.where(reply_id: @reply.id).count
            @reply.update(likes: like_count)
            render json: @reply
        else
            render json: {}
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
