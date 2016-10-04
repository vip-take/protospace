require 'rails_helper'

describe Prototype do
  let(:user) { FactoryGirl.build(:user)}
  let(:like) { FactoryGirl.build(:like)}
  let(:comment) { FactoryGirl.build(:comment)}
  let(:prototype_with_main_sub) { FactoryGirl.build(:prototype,:with_main_sub)}
  let(:prototype_with_sub) { FactoryGirl.build(:prototype,:with_sub)}
  describe 'Prototype#create' do
    describe '正常系確認' do
      it 'テキストとMainおよびsub画像での登録ができること' do
        proto = prototype_with_main_sub
        expect(proto).to be_valid
      end
    end

    describe '異常系確認' do
      it 'titleがない場合登録できないこと' do
        proto = prototype_with_main_sub
        proto.title = ""
        expect(proto.save).to be_falsey
      end

      it 'CatchCopyが無い場合登録できないこと' do
        proto = prototype_with_main_sub
        proto.catchcopy = ""
        expect(proto.save).to be_falsey
      end

      it 'conceptが無い場合登録できないこと' do
        proto = prototype_with_main_sub
        proto.concept = ""
        expect(proto.save).to be_falsey
      end

      it 'sub画像だけの(mainが無い)場合登録できないこと' do
        expect(prototype_with_sub.save).to be_falsey
      end
    end
  end

  describe 'Like' do
      it 'likeした場合Counterが上がること' do
        user.save
        prototype_with_main_sub.save
        like.user_id = user.id
        like.prototype_id = prototype_with_main_sub.id
        like.save
        prototype_with_main_sub.reload
        expect(prototype_with_main_sub.likes_count).to eq 1
      end

      it 'likeされていない場合、Counterが0であること' do
        prototype_with_main_sub.save
        expect(prototype_with_main_sub.likes_count).to eq 0
      end
  end

  describe 'comment' do
      it 'commentした場合Counterが上がること' do
        user.save
        prototype_with_main_sub.save
        comment.user_id = user.id
        comment.prototype_id = prototype_with_main_sub.id
        comment.save
        prototype_with_main_sub.reload
        expect(prototype_with_main_sub.comments_count).to eq 1
      end

      it 'commentされていない場合、Counterが0であること' do
        prototype_with_main_sub.save
        expect(prototype_with_main_sub.comments_count).to eq 0
      end
  end

  describe 'associations' do
    it 'prototypeが削除された場合、関連するlikeが消えること' do
      user.save
      prototype_with_main_sub.save
      like.user_id = user.id
      like.prototype_id = prototype_with_main_sub.id
      prototype_with_main_sub.destroy
      expect { like.reload }.to raise_error
    end

    it 'prototypeが削除された場合、関連するcommentが消えること' do
      user.save
      prototype_with_main_sub.save
      comment.user_id = user.id
      comment.prototype_id = prototype_with_main_sub.id
      prototype_with_main_sub.destroy
      expect { comment.reload }.to raise_error
    end
  end
end
