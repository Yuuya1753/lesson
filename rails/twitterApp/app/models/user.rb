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
    param[:limit] = 30
    if !(param.key?(:created_at))
      param[:created_at] = Time.now
    end
    if param.key?(:tweets_id)
      User.find_by_sql(['SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" < :tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit', param])
    else
      User.find_by_sql(['SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."created_at" < :created_at ORDER BY "tweets"."created_at" DESC LIMIT :limit', param])
    end
  end
  
  def self.count_new_tweets(param)
    User.find_by_sql(['SELECT COUNT(*) AS "count" FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" > :tweets_id', param])
  end
  
  def self.find_new_tweets(param)
    User.find_by_sql(['SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" > :tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit', param])
  end
end