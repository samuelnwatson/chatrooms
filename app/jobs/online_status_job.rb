class OnlineStatusJob < ApplicationJob
  queue_as :default

  def perform(channel: 'online_status', status: 'offline', user: 'default')
    ActionCable.server.broadcast channel,
    {
      status: status,
      user: user
    }
  end
end
