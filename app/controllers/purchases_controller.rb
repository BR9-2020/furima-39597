class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]
  before_action :check_seller
  before_action :authorize_user

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_shipment = PurchaseShipment.new
  end

  def create
    @purchase_shipment = PurchaseShipment.new(purchase_params)
    if @purchase_shipment.valid?
      pay_item
      @purchase_shipment.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipment).permit(:postcode, :shipping_region_id, :city_town_village, :street_address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def check_seller
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end

  def authorize_user
    return unless current_user.id == @item.user_id || @item.purchase.present?

    redirect_to root_path
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
