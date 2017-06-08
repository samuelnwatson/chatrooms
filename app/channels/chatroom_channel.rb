class ChatroomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chatroom'
  end

  def user_typing(data)
    ChatroomBroadcastJob.perform_now(chatroom: data['chatroom'], user_typing: data['user'])
  end
end
