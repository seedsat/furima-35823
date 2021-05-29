FactoryBot.define do
  factory :item do
    name { 'test' }
    info { 'テスト商品です' }
    category_id { 2 }
    itemstatus_id { 2 }
    deliverycharge_id { 3 }
    prefecture_id { 2 }
    shippingday_id { 2 }
    price { 10_000 }
    association :user

    after(:build) do |message|
      message.image.attach(io: File.open('public/images/test_img.jpg'), filename: 'test_img.jpg')
    end
  end
end
