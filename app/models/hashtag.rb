class Hashtag < ActiveRecord::Base
    has_many :sharps
    has_many :posts, through: :sharps
end
