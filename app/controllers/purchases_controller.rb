class PurchasesController < ApplicationController
  def index
    @purchase_shipment = PurchaseShipment.new
  end
end
