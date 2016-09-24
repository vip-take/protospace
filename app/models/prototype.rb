class Prototype < ActiveRecord::Base

  belongs_to :user

  # 親モデルによるimageファイルの一括更新
  has_many :images, dependent: :destroy
  accepts_nested_attributes_for :images, allow_destroy: true, reject_if: :parent_check

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

  def parent_check
    attributes['title'].blank?
  end

end
