class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :relationships, foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followee
  mount_uploader :icon, ImageUploader
end

class FolloweeTweet < ActiveRecord::Base
  def self.find(param = {})
    if !(param.key?(:limit))
      param[:limit] = 30
    end
    if !(param.key?(:tweets_id))
      param[:tweets_id] = Tweet.maximum('id') + 1
    end

    query_first_half = 'SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id"'
    query_last_half = ':tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit'

    query = query_first_half + param[:operator] + query_last_half
    
    User.find_by_sql([query, param])
  end
  
  def self.count_new_tweets(param)
    User.find_by_sql(['SELECT COUNT(*) AS "count" FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" > :tweets_id', param])
  end
end