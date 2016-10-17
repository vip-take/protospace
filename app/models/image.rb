class Image < ActiveRecord::Base

  belongs_to :prototype

  # モデル単体でのテストのみon。以下を有効にすると、protoytypeモデル経由でアクセス不可
  #http://ruby-rails.hatenadiary.com/entry/20141208/1418018874
  # validates :photo, presence: true
  # validates :role, presence: true

# Carrierwave設定
  mount_uploader :photo, AvatarUploader

# enumによるmainとsub画像の設定
  enum role: { main: 0, sub: 1 }

end
