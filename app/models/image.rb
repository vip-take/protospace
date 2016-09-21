class Image < ActiveRecord::Base

  belongs_to :prototype

# Carrierwave設定
  mount_uploader :photo, AvatarUploader

# enumによるmainとsub画像の設定
  enum role: { main: 0, sub: 1 }

end
