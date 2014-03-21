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
    @org = Org.new(org_params)
    if @org.save
      @org.org_user_memberships.create user: current_user, is_kegmeister: true
      flash[:success] = "Successfully created #{@org.name}"
      redirect_to org
    else
      flash[:danger] = "Failed to create org."
      render :new
    end
  end

  def update
    org = Org.find(params[:id])
    if org.update_attributes org_params
      flash[:success] = "Successfully updated #{org.name}"
      redirect_to org
    else
      flash[:danger] = "Failed to update #{org.name}"
      redirect_to org
    end
  end

  def destroy
    org = Org.find(params[:id])
    if org.destroy
      flash[:success] = "Successfully deleted #{org.name}"
      redirect_to root_path
    else
      flash[:danger] = "Failed to delete #{org.name}"
      redirect_to org
    end
  end

  private
  def org_params
    params.require(:org).permit(:name, :reminder_email)
  end
end
