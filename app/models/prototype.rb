class Prototype < ActiveRecord::Base

  belongs_to :user

  # 親モデルによるimageファイルの一括更新
  has_many :images
  accepts_nested_attributes_for :images

end
