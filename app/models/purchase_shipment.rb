class PurchaseShipment
  include ActiveModel::Model
  attr_accessor :postcode, :shipping_region_id, :city_town_village, :street_address, :building_name, :phone_number, :user_id,
                :item_id, :token

  with_options presence: true do
    validates :postcode, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :shipping_region_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city_town_village
    validates :street_address
    validates :phone_number, format: { with: /\A[0-9]{11}\z/, message: 'is invalid' }
    validates :user_id
    validates :item_id
    validates :token
  end

  def save
    purchase = Purchase.create(user_id:, item_id:)
    Shipment.create(postcode:, shipping_region_id:, city_town_village:,
                    street_address:, building_name:, phone_number:, purchase_id: purchase.id)
  end
end
