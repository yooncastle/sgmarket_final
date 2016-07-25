class Post < ActiveRecord::Base
    belongs_to :user
    has_many :replies
    has_many :hashtags
    has_many :tags, through: :hashtags
end
