class WebsiteController < ApplicationController
  def index
    if current_user && current_user.orgs.present?
      redirect_to current_user.orgs.first
    end
  end
end