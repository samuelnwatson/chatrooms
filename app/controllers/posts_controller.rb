class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    authorize @post
  end

  def create
    @post = Post.new(post_params)

    authorize @post

    if @post.save
      poster = Member.new(chatroom_id: @post.chatroom_id, user_id: current_user.id)
      if poster.save
        ChatroomBroadcastJob.perform_now(channel: "chatroom",
          content: @post.content, chatroom: @post.chatroom_id, user: current_user.username, member: true)
      else
        ChatroomBroadcastJob.perform_now(channel: "chatroom",
          content: @post.content, chatroom: @post.chatroom_id, user: current_user.username)
      end
    else
      flash[:error] = @post.errors.full_messages.to_sentence
      redirect_to chatroom_url(@post.chatroom)
    end
  end

  def edit
    authorize @post
  end

  def update
    chatroom = @post.chatroom
    authorize @post
    if @post.update(post_params)
      redirect_to chatroom
    else
      render 'posts/form'
    end
  end

  def destroy
    chatroom = @post.chatroom
    authorize @post
    if @post.destroy
      flash[:alert] = "Post Deleted"
      redirect_to chatroom
    else
      flash[:alert] = "Post could not be deleted"
    end
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :chatroom_id, :user_id)
    end
end
