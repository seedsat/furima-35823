class PurchaseAddress

  include ActiveModel::Model
  attr_accessor :price, :card_number, :exp_month, :exp_year, :cvc, :postal_coad, :prefecture_id, :city, :house_number, :building_name, :telephone_number, :user_id, :item_id
end