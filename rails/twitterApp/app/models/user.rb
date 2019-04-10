class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :tweets
  has_many :relationships, foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followee
end

class FolloweeTweet < ActiveRecord::Base
    def self.find(param = {})
      param[:limit] = 30
      if !(param.key?(:created_at))
        param[:created_at] = Time.now
      end
      User.find_by_sql(['SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."created_at" < :created_at ORDER BY "tweets"."created_at" DESC LIMIT :limit', param])
    end
end