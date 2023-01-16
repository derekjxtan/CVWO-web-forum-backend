class PostDislikesController < ApplicationController
    before_action :set_like, only: %i[ create ]
    before_action :set_dislike, only: %i[ destroy ]
    before_action :set_post, only: %i[ create destroy ] 

    # POST /dislike
    # Check database for existing dislike. Delete existing like if any. Create new dislike and update counts on post 
    def create
        if !dislike_exist
            if like_exist
                @like.destroy
            end

            @dislike = DislikedPost.create(user_id: @current_user.id, post_id: @post.id)

            dislike_count = DislikedPost.where(post_id: @post.id).count
            like_count = LikedPost.where(post_id: @post.id).count

            @post.update(likes: like_count, dislikes: dislike_count)
            
            render json: @post
        end
    end

    # DELETE /dislike
    # Check database for existing dislike and delete if there is. Update count on post
    def destroy
        if dislike_exist
            @dislike.destroy
            dislike_count = DislikedPost.where(post_id: @post.id).count
            @post.update(dislikes: dislike_count)
            render json: @post
        end
    end

    private
        # checks whether there is an existing LikedPost entry with the given userid and postid
        def like_exist
            LikedPost.where(user_id: @current_user.id, post_id: params[:post_id]).exists?
        end

        # checks whether there is an existing DislikedPost entry with the given userid and postid
        def dislike_exist
            DislikedPost.where(user_id: @current_user.id, post_id: params[:post_id]).exists?
        end

        # sets @like to the found entry in LikedPost with given userid and postid
        def set_like
            @like = LikedPost.find_by(user_id: @current_user.id, post_id: params[:post_id])
        end

        # sets @dislike to the found entry in DisikedPost with given userid and postid
        def set_dislike
            @dislike = DislikedPost.find_by(user_id: @current_user.id, post_id: params[:post_id])
        end

        # sets @post to the entry in Post with given postid
        def set_post
            @post = Post.find(params[:post_id]);
        end
end