class OrgsController < ApplicationController

  def show
    @org = Org.find(params[:id])
  end
end
