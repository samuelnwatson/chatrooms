class ChatroomPolicy < ApplicationPolicy
  attr_reader :user, :chatroom

  def initialize(user, chatroom)
    @user = user
    @chatroom = chatroom
  end

  def index?
    user
  end

  def show?
    user
  end

  def create?
    user
  end

  def new?
    create?
  end

  def update?
    user&.is_admin? || chatroom&.creator == user&.username
  end

  def edit?
    user&.is_admin? || chatroom&.creator == user&.username
  end

  def destroy?
    user&.is_admin? || chatroom&.creator == user&.username
  end
end
