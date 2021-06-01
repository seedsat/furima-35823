class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :itemstatus
  belongs_to :deliverycharge
  belongs_to :prefecture
  belongs_to :shippingday

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :info, length: { maximum: 1000 }
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999,
                              message: 'is out of setting range' }
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  end

  # ジャンルの選択が「--」の時は保存できないようにする
  with_options presence: true, numericality: { other_than: 1 } do
    validates :category_id
    validates :itemstatus_id
    validates :deliverycharge_id
    validates :prefecture_id
    validates :shippingday_id
  end
end
