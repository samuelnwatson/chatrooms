class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception, prepend: true
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email]
    end

  private
    def set_user
      if current_user
        cookies[:username] = current_user.username || 'guest'
      end
    end
end
