class Post < ActiveRecord::Base
    include SimpleHashtag::Hashtaggable
    belongs_to :user
    has_many :replies
    has_many :sharps
    has_many :hashtags, through: :sharps
end
