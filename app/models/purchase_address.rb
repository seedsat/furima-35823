class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :price, :token, :postal_coad, :prefecture_id, :city, :house_number, :building_name, :telephone_number, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :postal_coad, format { with: /\A\d{3}-\d{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality { other_than: 0, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :telephone_number, numericality: { only_integer: true, message: 'is invalid. Input only number' }
    validates :user_id
    validates :item_id
  end
end