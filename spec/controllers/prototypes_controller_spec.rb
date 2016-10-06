require 'rails_helper'
require 'pry-rails'

describe PrototypesController do
  let(:user) { FactoryGirl.build(:user)}
  let(:like) { FactoryGirl.build(:like)}
  let(:comment) { FactoryGirl.build(:comment)}
  let(:prototype_with_main_sub) { FactoryGirl.build(:prototype,:with_main_sub)}
  let(:prototype_with_sub) { FactoryGirl.build(:prototype,:with_sub)}
  describe 'サインイン済みユーザー' do
    before :each do
      user.save
      sign_in user
    end
    describe 'GET #new' do
      it '新規インスタンスが生成されること' do
        get :new
        expect(assigns(:proto)). to be_a_new(Prototype)
      end

      it 'newに対応したViewが表示されること' do
        get :new
        expect(response).to render_template :new
      end
    end

    describe 'GET #show' do
      before :each do
        prototype_with_main_sub.save
      end
      it 'リクエストされたPrototypeがセットされていること' do
        get :show, id: prototype_with_main_sub
        expect(assigns(:proto)).to eq prototype_with_main_sub
      end
      it 'likeが取得できること' do
        like.prototype_id = prototype_with_main_sub.id
        like.user_id = user.id
        like.save
        get :show, id: prototype_with_main_sub
        expect(assigns(:like)).to eq like
      end
      it 'commentインスタンスが取得できること' do
        get :show, id: prototype_with_main_sub
        expect(assigns(:comment)).to be_a_new(Comment)
      end
      it 'showに対応したviewが表示されること' do
        get :show, id: prototype_with_main_sub
        expect(response).to render_template :show
      end
    end

    describe 'POST #create' do
      describe '正常系確認' do
        it 'DBに保存できること' do
          tags = ["T1","T2","T3"]
          user.save
          sign_in user
          images_params = { images_attributes: [ attributes_for(:image_default_main) ] }
          expect { post :create, prototype: attributes_for(:prototype).merge( images_params ), tags: tags}.to change(Prototype, :count).by(1)
        end
        it 'rootに飛ばされること' do
        end
        it 'flashメッセージが表示されること' do
        end
      end

      describe '異常系確認' do
        it 'バリデーションにより登録できないこと' do
        end
        it 'Prototype投稿画面に飛ばされること' do
        end
        it 'flashメッセージが表示されること' do
        end
      end
    end

    describe 'GET #edit' do
      it 'リクエストされたprototypeがセットされていること' do
      end
      it 'main画像が取得できること' do
      end
      it 'sub画像が取得できること' do
      end
      it 'editに対応したViewが表示されること' do
      end
    end

    describe 'PATCH #update' do
      describe '正常系確認' do
        it 'リクエストされたprototypeがセットされていること' do
        end
        it 'prototype情報が変更できること' do
        end
        it 'showページにリダイレクトされること' do
        end
        it 'flashメッセージが表示されること' do
        end
      end
      describe '異常系確認' do
        it 'リクエストされたprototypeがセットされていること' do
        end
        it 'バリデーションによりPrototypeがアップデートできないこと' do
        end
        it '編集ページにリダイレクトされること' do
        end
        it 'flashメッセージが表示されること' do
        end
      end
    end

    describe 'DELETE #destroy' do
      it 'リクエストされたprototypeがセットされていること' do
      end
      it 'prototypeが削除できること' do
      end
      it 'rootにリダイレクトされること' do
      end
      it 'flashメッセージが表示されること' do
      end
    end
  end

  describe '未サインインユーザー' do
    describe 'GET #new' do
      it 'サインインページにリダイレクトされること' do
      end
    end

    describe 'GET #create' do
      it 'サインインページにリダイレクトされること' do
      end
    end

    describe 'GET #edit' do
      it 'サインインページにリダイレクトされること' do
      end
    end

    describe 'GET #update' do
      it 'サインインページにリダイレクトされること' do
      end
    end

    describe 'GET #destroy' do
      it 'サインインページにリダイレクトされること' do
      end
    end
  end
end
