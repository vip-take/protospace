require 'rails_helper'
require 'pry-rails'

describe Prototypes::PopularsController do
  let(:user) { FactoryGirl.build(:user)}
  let(:like) { FactoryGirl.build(:like)}
  let(:comment) { FactoryGirl.build(:comment)}
  let(:prototype_with_main_sub) { FactoryGirl.build(:prototype,:with_main_sub)}
  let(:prototype_with_sub) { FactoryGirl.build(:prototype,:with_sub)}
  describe 'サインイン済みユーザー' do
    describe 'GET #index' do
      before :each do
        FactoryGirl.create_list(:prototype, 8, :with_main_sub)
        FactoryGirl.create_list(:like,3, prototype_id: 3)
        FactoryGirl.create_list(:like,2, prototype_id: 2)
      end

      it 'Prototypeの一覧がセットされること' do
        get :index
        protos = Prototype.includes(:images).order("likes_count DESC")
        expect(assigns(:protos)).to match_array(protos)
      end
      it 'indexに対応したViewが表示されること' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
