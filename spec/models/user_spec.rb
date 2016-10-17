require 'rails_helper'

describe User do
  describe '#create' do
    let(:user) { FactoryGirl.build(:user) }
    describe '正常系確認' do
      it "全て正常値の場合登録できること" do
        expect(user).to be_valid
      end
    end

    describe '異常系確認' do
      it 'nameが空の場合登録できないこと' do
        user.name = ""
        expect(user.save).to be_falsey
      end

      it 'emailが空の場合登録できないこと' do
        user.email = ""
        expect(user.save).to be_falsey
      end

      it '同じemailが存在している場合登録できないこと' do
        built_users = build_list(:user, 2)
        user01 = built_users[0]
        user01.save
        user02 = built_users[1]
        user02.email = user01.email
        expect(user02.save).to be_falsey
      end

      it 'passowrdが空の場合登録できないこと' do
        user.password = ""
        expect(user.save).to be_falsey
      end

      it 'password_confirmationが空の場合登録できないこと' do
        user.password_confirmation = ""
        expect(user.save).to be_falsey
      end

      it 'passwordとpassword_confirmationの値が異なる場合登録できないこと' do
        user.password = "123456"
        user.password_confirmation = "123455"
        expect(user.save).to be_falsey
      end

      it 'passwordが5文字以下の場合登録できないこと' do
        user.password = "12345"
        user.password_confirmation = "12345"
        expect(user.save).to be_falsey
      end

    end
  end
end
