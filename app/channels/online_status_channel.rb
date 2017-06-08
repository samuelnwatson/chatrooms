class OnlineStatusChannel < ApplicationCable::Channel

  def self.subscribers
    @subscribers ||= []
  end

  def subscribed
    stream_from "online_status"
    unless self.class.subscribers.include? current_user.username
      self.class.subscribers << current_user.username
    end
    online
  end

  def unsubscribed
    self.class.subscribers.delete current_user.username
    offline
  end

  def online
    current_status("online")
  end

  def offline
    current_status("offline")
  end

  def away
    current_status("away")
  end

  private

    def current_status(status)
      OnlineStatusJob.perform_now(status: status, user: current_user.username)
    end
end
