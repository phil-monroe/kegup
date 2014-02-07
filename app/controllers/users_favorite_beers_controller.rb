class UsersFavoriteBeersController < ApplicationController
  def index
    @favorite_beers = current_user.beers.load
  end

  def create
    beer = Beer.find(params[:users_favorite_beer][:beer_id])
    current_user.favorite_beers.create!(beer: beer)
    flash[:success] = "Unable to add beer to your favorite beers."
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
    flash[:danger] = "Unable to remove #{fav_beer.beer.name} from your favorite beers."
  ensure
    redirect_to :back
  end
end
