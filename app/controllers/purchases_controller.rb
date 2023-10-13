class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]

  def index
    @purchase_shipment = PurchaseShipment.new
  end

  def create
    @purchase_shipment = PurchaseShipment.new(purchase_params)
    if @purchase_shipment.valid?
      @purchase_shipment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipment).permit(:postcode, :shipping_region_id, :city_town_village, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id)
  end

  def find_item
    @item = Item.find(params[:item_id])
  end
end
