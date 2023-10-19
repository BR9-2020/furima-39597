require 'rails_helper'

RSpec.describe PurchaseShipment, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @purchase_shipment = FactoryBot.build(:purchase_shipment,user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end
  describe '発送先情報の登録' do
    context '発送先情報が登録できる時' do
      it '全ての情報が入力されていれば保存できる' do
        expect(@purchase_shipment).to be_valid
      end
      it '郵便番号が「3桁-4桁」の数字であれば保存できる' do
        @purchase_shipment.postcode = '999-9999'
        expect(@purchase_shipment).to be_valid
      end
      it '都道府県が「---」以外であれば保存できる' do
        @purchase_shipment.shipping_region_id = 2
        expect(@purchase_shipment).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @purchase_shipment.city_town_village = '青森市'
        expect(@purchase_shipment).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @purchase_shipment.street_address = '横浜町7'
        expect(@purchase_shipment).to be_valid
      end
      it '建物名は空でも保存できる' do
        @purchase_shipment.building_name = nil
        expect(@purchase_shipment).to be_valid
      end
      it '電話番号は10桁以上11桁以内の半角数値なら保存できる' do
        @purchase_shipment.phone_number = 99_999_999_999
        expect(@purchase_shipment).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @purchase_shipment.user_id = 1
        expect(@purchase_shipment).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @purchase_shipment.item_id = 1
        expect(@purchase_shipment).to be_valid
      end
    end
    context '発送先情報が登録できない時' do
      it '郵便番号が空だと保存できない' do
        @purchase_shipment.postcode = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Postcode can't be blank",
                                                                   'Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できない' do
        @purchase_shipment.postcode = 9_999_999
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できない' do
        @purchase_shipment.shipping_region_id = 1
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Shipping region can't be blank")
      end
      it '都道府県が空だと保存できない' do
        @purchase_shipment.shipping_region_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Shipping region can't be blank")
      end
      it '市区町村が空だと保存できない' do
        @purchase_shipment.city_town_village = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("City town village can't be blank")
      end
      it '番地が空だと保存できない' do
        @purchase_shipment.street_address = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Street address can't be blank")
      end
      it '電話番号が空だと保存できない' do
        @purchase_shipment.phone_number = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号に-があると保存できない' do
        @purchase_shipment.phone_number = '999 - 9999 - 9999'
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できない' do
        @purchase_shipment.phone_number = 999_999_999_999_999
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end
      it 'user_idが空だと保存できない' do
        @purchase_shipment.user_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @purchase_shipment.item_id = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Item can't be blank")
      end
      it 'トークンが空だと保存できない' do
        @purchase_shipment.token = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Token can't be blank")
      end
      it '電話番号が空では購入でkない' do
        @purchase_shipment.phone_number = nil
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下では購入できない' do
        @purchase_shipment.phone_number = 99999
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上では購入できない' do
        @purchase_shipment.phone_number = 999999999999999
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号に半角数字以外が含まれている場合は購入できない（※半角数字以外が一文字でも含まれていれば良い）' do
        @purchase_shipment.phone_number = 999-9999-9999
        @purchase_shipment.valid?
        expect(@purchase_shipment.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end
