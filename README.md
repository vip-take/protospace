#User
## association
    has_many :prototypes, :comments, :likes
## table
 - t.string :Name
 - t.string :password
 - t.string :email
 - t.string :group
 - t.text :profile
 - t.string :works
 - t.text :avatar


#Prototype
## association
    has_many :comments, likes, capturedimages, tags
    belongs_to :user
## table
 - t.text :catchcopy
 - t.text concept
 - t.integer :user_id


#CapturedImage
## association
    belongs_to :prototype_id
## table
 - t.integer :prototype_id
 - t.text :photo


#like
## association
    belongs_to :user, :prototype
##table
 - t.integer :prototype_id
 - t.integer :user_id


#Commet
## association
    belongs_to: :user, :prototype
## table
 - t.text :text
 - t.integer :user_id
 - t.integer :prototype_id
