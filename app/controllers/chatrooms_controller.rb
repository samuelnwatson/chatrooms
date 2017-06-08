class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_chatroom_slug, only: [:show, :update, :edit, :destroy]

  def index
    @chatrooms = Chatroom.order('created_at DESC').all
    authorize @chatrooms
  end

  def show
    authorize @chatroom
    @post = Post.new
  end

  def create
    @chatroom = Chatroom.new(chatroom_params)
    authorize @chatroom
    @chatroom.slug = @chatroom.topic.parameterize
    @chatroom.creator = current_user.username

    if @chatroom.save
      flash[:alert] = "Chatroom created!"
      redirect_to @chatroom
    else
      render 'new'
    end
  end

  def new
    @chatroom = Chatroom.new
    authorize @chatroom
  end

  def edit
    authorize @chatroom
  end

  def update
    authorize @chatroom
    @chatroom.slug = @chatroom.topic.parameterize
    if @chatroom.update(chatroom_params)
      redirect_to @chatroom
    else
      render 'edit'
    end
  end

  def destroy
    authorize @chatroom
    @chatroom.destroy
    flash[:alert] = "Chatroom Deleted"
    redirect_to chatrooms_url
  end

  private

    def chatroom_params
      params.require(:chatroom).permit(:topic, :description, :posts, :slug, :creator)
    end

    def find_chatroom
      Chatroom.find_by(params[:id])
    end

    def find_chatroom_slug
      @chatroom = Chatroom.find_by_slug(params[:id])
    end
end
