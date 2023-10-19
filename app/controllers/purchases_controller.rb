class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_item, only: [:index, :create]
  before_action :check_seller
  before_action :authorize_user

  def index
    @purchase_shipment = PurchaseShipment.new
  end

  def create
    @purchase_shipment = PurchaseShipment.new(purchase_params)
    if @purchase_shipment.valid?
      pay_item
      @purchase_shipment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.require(:purchase_shipment).permit(:postcode, :shipping_region_id, :city_town_village, :street_address, :building_name, :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def find_item
    @item = Item.find(params[:item_id])
  end

  def check_seller
    if current_user.id == @item.user_id
      redirect_to root_path 
    end
  end

  def authorize_user
    if current_user.id == @item.user_id || @item.purchase.present? # ログインユーザーが出品者か、または商品が売り切れている場合
      redirect_to root_path # トップページにリダイレクト
    end
  end

  def pay_item
    Payjp.api_key = "sk_test_1afdaa97c0f54dedbc5f4c6a"  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: purchase_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end
