class OrgsController < ApplicationController
  def index
    @orgs = Org.order('updated_at DESC').all
  end

  def show
    @org = Org.find(params[:id])
  end

  def new
    @org = Org.new
  end

  def create
    org = Org.new(org_params)
    if org.save
      org.org_user_memberships.create user: current_user, is_kegmeister: true
      flash[:success] = "Successfully created #{org.name}"
      redirect_to org
    else
      render :new
    end
  end

  private
  def org_params
    params.require(:org).permit(:name)
  end
end
