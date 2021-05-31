class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :house_number,
                :telephone_number, :building_name, :token, :user_id, :item_id, :purchase_id

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :house_number
    validates :telephone_number, numericality: { only_integer: true, message: "is invalid. Input only number" }
    validates :telephone_number, format: { with: /\A\d{10,11}\z/, message: 'is out of setting range' }
    validates :token
    validates :user_id
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                   house_number: house_number, building_name: building_name, telephone_number: telephone_number, purchase_id: purchase.id)
  end
end