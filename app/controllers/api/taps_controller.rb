module Api
  class TapsController < ApiController
    def finished
      tap.keg = nil
      tap.save
      render json: {status: :success}
    end

    def tapped
      tap.keg = keg
      tap.save
      render json: {status: :success}
    end

    private
    def tap
      @tap ||= org.taps.find(params[:id])
    end

    def org
      @org ||= Org.find(params[:org_id])
    end

    def keg
      @keg ||= org.kegs.find(params[:keg_id])
    end
  end
end