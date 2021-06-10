require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @comment = FactoryBot.build(:comment, user_id: user.id, item_id: item.id)
    sleep 1
  end

  context 'コメントができるとき' do
    it '正しく入力出来ていれば登録出来る' do
      expect(@comment).to be_valid
    end
  end

  context 'コメントができないとき' do
    it 'コメントを入力しなければ投稿できない' do
      @comment.text = ""
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Textを入力してください'
    end
    it 'ユーザーが存在しなければ投稿できない' do
      @comment.user_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Userを入力してください'
    end
    it '出品商品が存在しなければ投稿できない' do
      @comment.item_id = nil
      @comment.valid?
      expect(@comment.errors.full_messages).to include 'Itemを入力してください'
    end
  end
end
