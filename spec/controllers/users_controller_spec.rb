require 'rails_helper'
require 'pry-rails'

describe UsersController do
  let(:user) { FactoryGirl.build(:user)}
  let(:like) { FactoryGirl.build(:like)}
  let(:comment) { FactoryGirl.build(:comment)}
  let(:prototype_with_main_sub) { FactoryGirl.build(:prototype, :with_main_sub)}
  let(:prototype_with_sub) { FactoryGirl.build(:prototype, :with_sub)}
  describe 'サインイン済みユーザー' do
    describe 'GET #show' do
      before :each do
        user.save
        get :show , id: user
      end
      it 'ユーザー情報がセットされること' do
        expect(assigns(:user)).to eq user
      end

      it 'showに対応したViewが表示されること' do
        expect(response).to render_template :show
      end
    end

    describe 'GET #edit' do
      before :each do
        user.save
        get :edit, id: user
      end
      it 'ユーザー情報がセットされること' do
        expect(user).to eq user
      end

      it 'editに対応したViewが表示されること' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        user.save
      end
      it '変更前のユーザー情報がセットされること' do
        patch :update , id: user, user: attributes_for(:user)
        expect(assigns(:user)).to eq user
      end

      it 'ユーザー情報が変更できること' do
        patch :update , id: user, user: attributes_for(:user, name: 'hogehoge')
        user.reload
        expect(user.name).to eq('hogehoge')
      end

      it 'パスワード変更無しの場合、root pathにリダイレクトされること' do
        patch :update , id: user, user: attributes_for(:user, name: 'hogehoge', password: "", password_confirmation: "")
        expect(response).to redirect_to(root_path)
      end

      it 'パスワード変更した場合、signinページにリダイレクトされること' do
        patch :update , id: user, user: attributes_for(:user, name: 'hogehoge', password: "654321", password_confirmation: "654321")
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'update messageが表示されること' do
        patch :update , id: user, user: attributes_for(:user, name: 'hogehoge', password: "", password_confirmation: "")
        expect(flash[:notice]).to be_present
      end
    end
  end

  describe '未サインインユーザー' do
    describe 'GET #edit' do
      it 'サインインページにリダイレクトされること' do
        expect { get :edit }.to raise_error
      end
    end
    describe 'GET #update' do
      it 'サインインページにリダイレクトされること' do
        expect { patch :edit }.to raise_error
      end
    end
  end
end
