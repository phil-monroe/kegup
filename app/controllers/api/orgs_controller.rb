module Api
  class OrgsController < ApiController
    def bother
      user = org.users.find(params[:user_id])
      OrgMailer.bother_kegmeister_email(org, user).deliver
      render json: {status: :success}
    end


    private
    def org
      @org ||= Org.find(params[:id])
    end
  end
end