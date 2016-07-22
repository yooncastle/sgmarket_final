class Post < ActiveRecord::Base
    belongs_to :user
    has_many :replies
    has_many :sharps
    has_many :hashtags, through: :sharps
end
