class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :prototype, counter_cache: :comments_count

  validates :text, presence: true
end
