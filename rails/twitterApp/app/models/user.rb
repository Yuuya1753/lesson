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

    # query_first_half = 'SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id"'
    # query_last_half = ':tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit'

    # query = query_first_half + param[:operator] + query_last_half
    # query = 'SELECT * FROM (SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" < :tweets_id UNION SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "retweets" ON "followee_user"."id" = "retweets"."user_id" INNER JOIN "tweets" ON "retweets"."tweet_id" = "tweets"."id" WHERE "tweets"."id" < :tweets_id) AS "tweet" ORDER BY "tweet"."created_at" DESC LIMIT :limit'
    # query = %|
    #   WITH followees AS (
    #   SELECT "users".*
    #   FROM "users"
    #   INNER JOIN "relationships"
    #   ON "users"."id" = "relationships"."followee_id"
    #   WHERE "relationships"."follower_id" = :follower_id
    #   )
    #   SELECT * FROM (
    #   SELECT tweets.*, followees.email as tweeted_email, NULL AS retweeted_email FROM followees INNER JOIN tweets ON followees.id = tweets.user_id WHERE "tweets"."id" < :tweets_id
    #   UNION
    #   SELECT tweets.*, users.email AS tweeted_email, followees.email AS retweeted_email FROM followees INNER JOIN retweets ON followees.id = retweets.user_id INNER JOIN tweets ON retweets.tweet_id = tweets.id INNER JOIN users ON tweets.user_id = users.id WHERE "tweets"."id" < :tweets_id
    #   ) ORDER BY created_at DESC LIMIT :limit
    # |
    # query = 'WITH followee_user AS (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) SELECT * FROM (SELECT "tweets".* FROM followee_user INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" < :tweets_id UNION SELECT "tweets".* FROM followee_user INNER JOIN "retweets" ON "followee_user"."id" = "retweets"."user_id" INNER JOIN "tweets" ON "retweets"."tweet_id" = "tweets"."id" WHERE "tweets"."id" < :tweets_id) AS "tweet" ORDER BY "tweet"."created_at" DESC LIMIT :limit'
    # User.find_by_sql([query, param])
    User.find_by_sql([ %|
      WITH followees AS (
      SELECT "users".*
      FROM "users"
      INNER JOIN "relationships"
      ON "users"."id" = "relationships"."followee_id"
      WHERE "relationships"."follower_id" = :follower_id
      )
      SELECT * FROM (
      SELECT tweets.*, followees.email as tweeted_email, NULL AS retweeted_email FROM followees INNER JOIN tweets ON followees.id = tweets.user_id WHERE "tweets"."id" < :tweets_id
      UNION
      SELECT tweets.*, users.email AS tweeted_email, followees.email AS retweeted_email FROM followees INNER JOIN retweets ON followees.id = retweets.user_id INNER JOIN tweets ON retweets.tweet_id = tweets.id INNER JOIN users ON tweets.user_id = users.id WHERE "tweets"."id" < :tweets_id
      ) ORDER BY created_at DESC LIMIT :limit
      |, param ])

    # query = 'SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" < :tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit'
    # user_a = User.find_by_sql([query, param])
    # p user_a
    
    # query = 'SELECT * FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "retweets" ON "followee_user"."id" = "retweets"."user_id" INNER JOIN "tweets" ON "retweets"."tweet_id" = "tweets"."id" WHERE "tweets"."id" < :tweets_id ORDER BY "tweets"."created_at" DESC LIMIT :limit'
    # user_b = User.find_by_sql([query, param])
    # p user_b
  end
  
  def self.count_new_tweets(param)
    User.find_by_sql(['SELECT COUNT(*) AS "count" FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" > :tweets_id', param])
  end
end