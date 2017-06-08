class PostPolicy < ApplicationPolicy
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def create?
    user
  end

  def new?
    user
  end

  def edit?
    post&.user&.id == user&.id
  end

  def update?
    post&.user&.id == user&.id
  end

  def destroy?
    user&.is_admin?
  end
end
