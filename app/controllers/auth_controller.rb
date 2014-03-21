class AuthController < ApplicationController
  after_filter :my_beers_reminder, only: :facebook

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

  def my_beers_reminder
    if current_user.favorite_beers.count == 0
      flash[:info] = "Head over to <b>'#{view_context.link_to('My Beers', users_favorite_beers_path)}'</b> to get your favorite beers suggested to your friendly neighborhood kegmeisters!".html_safe
    end
  end
end
