require 'rails_helper'

describe Image do
  describe '#create' do
    let(:image) { FactoryGirl.build(:image, :main)}
    let(:main_ico) { FactoryGirl.build(:image, :main_ico)}
    describe '正常系確認' do
      it 'メイン画像が保存できること' do
        expect(image).to be_valid
      end
    end
    describe '異常系確認' do
      it '画像が無い場合保存できないこと' do
        image.photo = ""
        expect(image.save).to be_falsey
      end

      it '特定以外の画像の場合保存できないこと' do
        expect(main_ico.save).to be_falsey
      end

      it 'roleが無い場合保存できないこと' do
        image.role = ""
        expect(image.save).to be_falsey
      end
    end
  end
end
