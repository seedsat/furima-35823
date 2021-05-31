require 'rails_helper'

RSpec.describe PurchaseAddress, type: :model do
  before do
    @purchase_address = FactoryBot.build(:purchase_address)
  end

  describe '購入処理' do
    context '購入できるとき' do
      it '正しく入力されていれば購入できる' do
        expect(@purchase_address).to be_valid
      end
      it '建物名が空でも登録できる' do
        @purchase_address.building_name = ""
        expect(@purchase_address).to be_valid
      end
    end

    context '購入できないとき' do
      it 'トークンが空では購入できない' do
        @purchase_address.token = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Token can't be blank"
      end
      it '郵便番号が空では購入できない' do
        @purchase_address.postal_code = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code can't be blank"
      end
      it '郵便番号にハイフンがなかったら購入できない' do
        @purchase_address.postal_code = '1111111'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '郵便番号が全角（ハイフンあり）では購入できない' do
        @purchase_address.postal_code = '１１１−１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '郵便番号が全角（ハイフンなし）では購入できない' do
        @purchase_address.postal_code = '１１１１１１１'
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Postal code is invalid. Include hyphen(-)"
      end
      it '都道府県が選択されていなければ購入できない' do
        @purchase_address.prefecture_id = 1
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Prefecture can't be blank"
      end
      it '市区町村が空だったら購入できない' do
        @purchase_address.city = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "City can't be blank"
      end
      it '番地が空だと購入できない' do
        @purchase_address.house_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "House number can't be blank"
      end
      it '電話番号が空だと購入できない' do
        @purchase_address.telephone_number = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number is invalid. Input only number"
      end
      it '電話番号が全角数字だと購入できない' do
        @purchase_address.telephone_number = "１１１１１１１１１１１"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number is invalid. Input only number"
      end
      it '電話番号が10桁以下では購入できない' do
        @purchase_address.telephone_number = "11111"
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "Telephone number is out of setting range"
      end
      it 'user_idが空だったら購入できない' do
        @purchase_address.user_id = ""
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include "User can't be blank"
      end
    end
  end
end