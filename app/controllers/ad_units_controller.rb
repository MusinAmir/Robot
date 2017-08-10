class AdUnitsController < ApplicationController
    before_action :set_ad_unit, only: [ :destroy]

  def index
    @ad_units = AdUnit.all
  end

  def new
    @ad_unit = AdUnit.new
  end 

  def create
    @account = Account.find(params[:account_id])
    @account.status = 0
    @account.save
    @ad_unit = @account.ad_units.create(ad_unit_params)
     respond_to do |format|
      if @ad_unit.save
        format.html { redirect_to @account}
        format.json { render :show, status: :created, location: @account }
      else
        
        format.json { render json: @ad_units.errors, status: :unprocessable_entity }
        format.html { redirect_to @account }
      end
    end
  end

  def destroy
    @account = Account.find(params[:account_id])
    @ad_unit = @account.ad_units.find(params[:id])
    unless (@ad_unit.status == 2 || @ad_unit.status == 1)
      @ad_unit.destroy
      respond_to do |format|
      format.html { redirect_to @account }
      format.json { head :no_content }
      end
    end
  end

  private
  def set_ad_unit
      @account = Account.find(params[:account_id])
      @ad_unit = @account.ad_units.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_unit_params
      params.require(:ad_unit).permit(:name, :url, :status, :error_message)
    end
end
