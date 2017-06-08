class Admin::AdminController < ApplicationController
  protect_from_forgery with: :exception, prepend: true
  before_action :admin_only

  def index
    @admins = User.where(admin: true)
  end

  private

    def admin_only
      unless current_user && current_user.admin?
        redirect_to root_path, notice: "You are not admin."
      end
    end
end
