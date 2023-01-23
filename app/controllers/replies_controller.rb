class RepliesController < ApplicationController
  skip_before_action :authenticate_user, only: %i[ index show ]
  before_action :set_reply, only: %i[ show update destroy ]

  # GET /replies
  def index
    @replies = Reply.all.order('created_at ASC')

    render json: @replies
  end

  # GET /replies/1
  def show
    render json: @reply
  end

  # POST /replies
  def create
    @reply = Reply.new(reply_params)

    if @reply.save
      render json: @reply, status: :created, location: @reply
      if @reply.reply_id != nil
        count = Reply.where(reply_id: @reply.reply_id).count
        Reply.find(@reply.reply_id).update(replies_count: count)
      end
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /replies/1
  def update
    if @reply.user_id != @current_user.id
      render json: @reply.errors, status: :unauthorized
    elsif @reply.update(reply_params)
      render json: @reply
    else
      render json: @reply.errors, status: :unprocessable_entity
    end
  end

  # DELETE /replies/1
  def destroy
    if @reply.user_id == @current_user.id
      @reply.destroy
      if @reply.reply_id != nil
        count = Reply.where(reply_id: @reply.reply_id).count
        Reply.find(@reply.reply_id).update(replies_count: count)  
      end
    else
      render json: @reply.errors, status: :unauthorized
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reply
      @reply = Reply.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reply_params
      params.require(:reply).permit(:body, :user_id, :post_id, :reply_id)
    end
end
