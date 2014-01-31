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
    org = Org.find params[:org_id]
    membership = org.org_user_memberships.find(params[:id])

    if membership.update membership_params
      flash[:success] = "Successfully modified #{membership.user.name}'s membership in #{org.name}!"
    else
      flash[:danger] =  "Unable to modify #{membership.user.name}'s membership in #{org.name}!"
    end
    redirect_to :back
  end

  def destroy
    org = Org.find params[:org_id]
    membership = org.org_user_memberships.find(params[:id])
    if membership.destroy
      flash[:success] = "Successfully terminated membership in #{org.name}!"
    else
      flash[:danger] = "Unable to terminate membership in #{org.name}!"
    end
    redirect_to :back
  end

  def membership_params
    params.require(:org_user_membership).permit!
  end
end