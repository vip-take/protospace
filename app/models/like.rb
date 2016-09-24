class Like < ActiveRecord::Base

  #counterをprototypeテーブルに挿入
  belongs_to :prototype, :counter_cache => :likes_count

  belongs_to :user

end
