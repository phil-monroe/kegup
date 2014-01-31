class AuthController < ApplicationController

  def facebook
    user = User.from_facebook(auth_hash)
    login user
    redirect_to root_path
  end

  def logout
    super
    redirect_to root_path
  end

  private
  def auth_hash
    request.env['omniauth.auth']
  end
end