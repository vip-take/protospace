require 'rails_helper'
require 'pry-rails'

describe PrototypesController do
  let(:user) { FactoryGirl.build(:user)}
  let(:like) { FactoryGirl.build(:like)}
  let(:comment) { FactoryGirl.build(:comment)}
  let(:prototype_with_main_sub) { FactoryGirl.build(:prototype,:with_main_sub)}
  let(:prototype_with_sub) { FactoryGirl.build(:prototype,:with_sub)}
  let(:prototype_with_main_value_main_with_tags) { FactoryGirl.build(:prototype,:with_main_value_main,:with_tags)}
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
        before :each do
          user.save
          sign_in user
          @tags = ["T1","T2","T3"]
          @images_params = { images_attributes: [ attributes_for(:image_default_main) ] }
        end
        it 'DBに保存できること' do
          expect { post :create, prototype: attributes_for(:prototype).merge( @images_params ), tags: @tags}.to change(Prototype, :count).by(1)
        end
        it 'rootに飛ばされること' do
          post :create, prototype: attributes_for(:prototype).merge( @images_params ), tags: @tags
          expect(response).to redirect_to(root_path)
        end
        it 'flashメッセージが表示されること' do
          post :create, prototype: attributes_for(:prototype).merge( @images_params ), tags: @tags
          expect(flash[:notice]).to be_present
        end
      end

      describe '異常系確認' do
        before :each do
          user.save
          sign_in user
          request.env["HTTP_REFERER"] = new_prototype_path
          @tags = ["T1","T2","T3"]
          @images_params = { images_attributes: [ attributes_for(:image_default_main) ] }
        end
        it 'バリデーションにより登録できないこと' do
          expect { post :create, prototype: attributes_for(:prototype, catchcopy: '').merge( @images_params ), tags: @tags}.not_to change(Prototype, :count)
        end
        it 'Prototype投稿画面に飛ばされること' do
          post :create, prototype: attributes_for(:prototype, catchcopy: '').merge( @images_params ), tags: @tags
          expect(response).to redirect_to(new_prototype_path)
        end
        it 'flashメッセージが表示されること' do
          post :create, prototype: attributes_for(:prototype, catchcopy: '').merge( @images_params ), tags: @tags
          expect(flash[:error]).to be_present
        end
      end
    end

    describe 'GET #edit' do
      before :each do
        user.save
        sign_in user
        prototype_with_main_sub.save
        get :edit, id: prototype_with_main_sub
      end
      it 'リクエストされたprototypeがセットされていること' do
        expect(assigns(:proto)).to eq prototype_with_main_sub
      end

      it 'main画像が取得できること' do
        expect(prototype_with_main_sub.images.first.photo).to be_present
      end

      it 'sub画像が取得できること' do
        expect(prototype_with_main_sub.images.second.photo).to be_present
      end
      it 'editに対応したViewが表示されること' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      let(:patch_update) { patch :update, id: @proto, prototype: attributes_for(:prototype, catchcopy: "hogehoge").merge( @images_params ) , tags: ["T1","T2","T3"]}
      let(:patch_update_cp_emply) { patch :update, id: @proto, prototype: attributes_for(:prototype,catchcopy: "").merge( @images_params ) , tags: ["T1","T2","T3"]}
      before :each do
        user.save
        sign_in user
        @proto = prototype_with_main_value_main_with_tags
        @proto.save
        @images_params = { images_attributes: [ attributes_for(:image_default_main) ] }
        request.env["HTTP_REFERER"] = edit_prototype_path(@proto)
      end
      describe '正常系確認' do
        it 'リクエストされたprototypeがセットされていること' do
          patch :update, id: @proto, prototype: attributes_for(:prototype).merge( @images_params ) , tags: ["T1","T2","T3"]
          expect(assigns(:proto)).to eq @proto
        end
        it 'prototype情報が変更できること' do
          patch_update
          @proto.reload
          expect(@proto.catchcopy).to eq('hogehoge')
        end
        it 'showページにリダイレクトされること' do
          patch_update
          @proto.reload
          expect(response).to redirect_to(root_path)
        end
        it 'flashメッセージが表示されること' do
          patch_update
          @proto.reload
          expect(flash[:notice]).to be_present
        end
      end
      describe '異常系確認' do
        it 'リクエストされたprototypeがセットされていること' do
          patch :update, id: @proto, prototype: attributes_for(:prototype).merge( @images_params ) , tags: ["T1","T2","T3"]
          expect(assigns(:proto)).to eq @proto
        end
        it 'バリデーションにより登録できないこと' do
          patch_update_cp_emply
          @proto.reload
          expect(@proto.catchcopy).not_to eq('')
        end
        it '編集ページにリダイレクトされること' do
          patch_update_cp_emply
          expect(response).to redirect_to(edit_prototype_path(@proto))
        end
        it 'flashメッセージが表示されること' do
          patch_update_cp_emply
          expect(flash[:error]).to be_present
        end
      end
    end

    describe 'DELETE #destroy' do
      let(:delete_proto){ delete :destroy, id: @proto }
      before :each do
        user.save
        sign_in user
        @proto = prototype_with_main_value_main_with_tags
        @proto.save
      end
      it 'リクエストされたprototypeがセットされていること' do
        delete_proto
        expect(assigns(:proto)).to eq @proto
      end
      it 'prototypeが削除できること' do
        expect{delete :destroy, id: @proto}.to change(Prototype, :count).by(-1)
      end
      it 'rootにリダイレクトされること' do
        delete_proto
        expect(response).to redirect_to(root_path)
      end
      it 'flashメッセージが表示されること' do
        delete_proto
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe '未サインインユーザー' do
    describe 'GET #new' do
      it 'サインインページにリダイレクトされること' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'POST #create' do
      it 'サインインページにリダイレクトされること' do
        post :create
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET #edit' do
      it 'サインインページにリダイレクトされること' do
        prototype_with_main_sub.save
        get :edit, id: prototype_with_main_sub
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH #update' do
      it 'サインインページにリダイレクトされること' do
        prototype_with_main_sub.save
        patch :update, id: prototype_with_main_sub
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'DELETE #destroy' do
      it 'サインインページにリダイレクトされること' do
        prototype_with_main_sub.save
        delete :destroy ,id: prototype_with_main_sub
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
