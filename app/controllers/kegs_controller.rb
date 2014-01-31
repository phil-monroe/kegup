class KegsController < ApplicationController

  def create
    puts params
    org = Org.find(params[:org_id])
    keg = org.kegs.build keg_params
    if keg.save
      flash[:success] = "Successfully added a keg of #{keg.beer.name}"
    else
      flash[:success] = "Unable to a keg..."
    end
    redirect_to org
  end

  private
  def keg_params
    params.require(:keg).permit(:beer_id)
  end
end