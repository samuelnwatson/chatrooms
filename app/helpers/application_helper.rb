module ApplicationHelper
  def users_only(&block)
    block.call if current_user
  end

  def admin?
    current_user.admin
  end

  def creator?(chatroom)
    current_user.username == chatroom.creator
  end

  def fetch_subscribers
    OnlineStatusChannel.subscribers
  end
end
