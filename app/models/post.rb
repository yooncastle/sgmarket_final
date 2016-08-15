class Post < ActiveRecord::Base
    belongs_to :user
    # connect with image model
    has_many :post_images
    has_many :replies
    has_many :hashtags
    has_many :tags, through: :hashtags
    # mount_uploader :avatars, MktimageUploader
end
