class Prototype < ActiveRecord::Base

  belongs_to :user

  # 親モデルによるimageファイルの一括更新
  has_many :images
  accepts_nested_attributes_for :images

  validates :title, presence: true
  validates :catchcopy, presence: true
  validates :concept, presence: true

  # Main画像のバリデーション
  validate :main_image_check

  def main_image_check
    unless images.first.photo.present?
      errors.add(:image, "Main image can't be blank :(")
    end
  end

end
