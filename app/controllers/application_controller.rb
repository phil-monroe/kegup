class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'slate'

  def login user
    session[:user_id] = user.id
  end

  def logout
    reset_session
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end
  helper_method :current_user


  def current_admin_user
    @current_admin_user ||= User.where(is_admin: true).find(session[:user_id])
  rescue ActiveRecord::RecordNotFound
    nil
  end
  helper_method :current_admin_user

  def authenticate_admin_user!
    redirect_to root_path if current_admin_user.blank?
  end

  def log_error err
    logger.error err
    err.backtrace.each do |l|
      logger.error " | #{l}"
    end
  end
end
