class PostSavesController < ApplicationController
    before_action :set_save, only: %i[ destroy ]
    before_action :set_post, only: %i[ create destroy ] 

    # POST /save
    # Check database for existing like. Delete existing dislike if any. Create new like and update counts on post 
    def create
        if !save_exist
            @save = SavedPost.create(user_id: @current_user.id, post_id: @post.id)
            save_count = SavedPost.where(post_id: @post.id).count
            @post.update(saves: save_count)
            render json: @post
        end
    end

    # DELETE /save
    # Check database for existing like and delete if there is. Update count on post
    def destroy
        if save_exist
            @save.destroy
            save_count = SavedPost.where(post_id: @post.id).count
            @post.update(saves: save_count)
            render json: @post
        end
    end

    private
        # checks whether there is an existing SavedPost entry with the given userid and postid
        def save_exist
            SavedPost.where(user_id: @current_user.id, post_id: params[:post_id]).exists?
        end

        # sets @save to the found entry in SavedPost with given userid and postid
        def set_save
            @save = SavedPost.find_by(user_id: @current_user.id, post_id: params[:post_id])
        end

        # sets @post to the entry in Post with given postid
        def set_post
            @post = Post.find(params[:post_id]);
        end
end