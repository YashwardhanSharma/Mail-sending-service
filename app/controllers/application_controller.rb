class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :require_admin

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_admin
    if current_user.nil?
      redirect_to login_path, alert: "Please login"
    elsif !current_user.admin?
      reset_session
      redirect_to login_path, alert: "Access denied. Admin only."
    end
  end
end
