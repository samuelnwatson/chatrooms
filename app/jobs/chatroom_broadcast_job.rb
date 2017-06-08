class ChatroomBroadcastJob < ApplicationJob
  queue_as :default

  def perform(channel: 'chatroom', content: 'default', chatroom: 'default', user: 'default',
     member: false, user_typing: 'default')
      ActionCable.server.broadcast channel,
      {
        post: content,
        user: user,
        chatroom: chatroom,
        member: member,
        user_typing: user_typing
      }
  end
end
