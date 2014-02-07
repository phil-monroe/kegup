class UsersFavoriteBeersController < ApplicationController
  def index
    @favorite_beers = current_user.beers_with_favorite_id.load
  end

  def create
    beer = Beer.find(params[:users_favorite_beer][:beer_id])
    current_user.favorite_beers.create!(beer: beer)
    flash[:success] = "Added #{beer.name} to your favorite beers."
  rescue ActiveRecord::RecordInvalid => e
    flash[:danger] = e.message
  rescue => e
    log_error e
    flash[:danger] = "Unable to add beer to your favorite beers."
  ensure
    redirect_to :back
  end

  def destroy
    fav_beer = current_user.favorite_beers.find(params[:id])
    fav_beer.destroy!
    flash[:success] = "Removed #{fav_beer.beer.name} from your favorite beers."
  rescue => e
    log_error e
    flash[:danger] = "Unable to remove that beer from your favorite beers."
  ensure
    redirect_to :back
  end
end
