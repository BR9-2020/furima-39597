class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to '/'
  end

  private
  def item_params
    prams.require(:item).permit(:image, :item_name, :item_description, :category_id, :condition_id, :shipping_cost_id, :shipping_region_id, :shipping_day_id, :price)
  end
end
