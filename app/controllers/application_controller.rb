class ApplicationController < ActionController::Base
  before_action :set_current_user
  helper_method :current_user, :signed_in?

  private

  def set_current_user
    Current.user = User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def current_user
    Current.user
  end

  def signed_in?
    current_user.present?
  end

  def require_authentication
    redirect_to new_session_path unless signed_in?
  end
end
