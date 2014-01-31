class Api::ApiController < ActionController::Base
  around_filter :handle_errors
  def handle_errors
    yield
  rescue => e
    render json: {status: :error, error: e.message, backtrace: e.backtrace}, status: 500
  end
end