class OrgUserMembershipsController < ApplicationController
  def create
    org = Org.find membership_params[:org_id]
    membership = org.org_user_memberships.build(user_id: membership_params[:user_id])
    if membership.save
      flash[:success] = "Successfully joined #{org.name}!"
    else
      flash[:danger] = "Unable to join org: #{org.name}"
    end

    redirect_to org
  end

  def update
    membership = OrgUserMembership.find(params[:id])
    membership.update membership_params
    redirect_to :back
  end

  def destroy
    membership = OrgUserMembership.find(params[:id])
    membership.destroy
    redirect_to :back
  end

  def membership_params
    params.require(:org_user_membership).permit!
  end
end