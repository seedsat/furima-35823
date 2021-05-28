class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :info, length: { maximum: 1000 }
    validates :category_id
    validates :deliverycharge_id
    validates :prefecture_id
    validates :shippingday_id
    validates :price
  end
end
