class UsersController < ApplicationController

  def edit
    @user = User.find(params[:id])

    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])

    authorize! :update, @user
  end

  def show
    @user = User.find(params[:id])
  end
end
