class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost
  belongs_to :shipping_region
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true
  validates :category_id, presence: true
  validates :condition_id, presence: true
  validates :shipping_cost_id, presence: true
  validates :shipping_region_id, presence: true
  validates :shipping_day_id, presence: true
  validates :price, presence: true, format: { with: /\A\d+\z/ }
  validates :category_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :condition_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_cost_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_day_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :shipping_region_id, numericality: { other_than: 1 , message: "can't be blank"}
  validates :price, numericality: {only_integer: true , greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999}

end
