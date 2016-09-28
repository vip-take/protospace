class Prototype < ActiveRecord::Base

  # form_forのためのタグインスタンス作成
  attr_accessor :tag1, :tag2, :tag3

  belongs_to :user

  # tag gemの設定
  acts_as_taggable_on :tags

  # commentsのアソシエーション。親が消えたらlikeも消えるように設定。
  has_many :comments, dependent: :destroy

  # likesのアソシエーション。親が消えたらlikeも消えるように設定。
  has_many :likes, dependent: :destroy

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
