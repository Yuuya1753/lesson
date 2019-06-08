class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:github, :twitter]
  has_many :tweets
  has_many :relationships, foreign_key: "follower_id"
  has_many :following, through: :relationships, source: :followee
  mount_uploader :icon, ImageUploader

  class << self
    def find_or_create_for_oauth(auth)
      find_or_create_by!(email: auth.info.email) do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.account = auth.info.name
        user.email = auth.info.email
        password = Devise.friendly_token[0..5]
        logger.debug password
        user.password = password
      end
    end

    def new_with_session(params, session)
      if user_attributes = session['devise.user_attributes']
        new(user_attributes) { |user| user.attributes = params }
      else
        super
      end
    end
  end
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
      SELECT tweets.*, followees.email as tweeted_email, NULL AS retweeted_email, followees.account AS tweeted_account, NULL AS retweeted_account FROM followees INNER JOIN tweets ON followees.id = tweets.user_id WHERE "tweets"."id" < :tweets_id
      UNION
      SELECT tweets.*, users.email AS tweeted_email, followees.email AS retweeted_email, users.account AS tweeted_account, followees.account AS retweeted_account FROM followees INNER JOIN retweets ON followees.id = retweets.user_id INNER JOIN tweets ON retweets.tweet_id = tweets.id INNER JOIN users ON tweets.user_id = users.id WHERE "tweets"."id" < :tweets_id
      ) ORDER BY created_at DESC LIMIT :limit
      |, param ])
  end
  
  def self.count_new_tweets(param)
    User.find_by_sql(['SELECT COUNT(*) AS "count" FROM (SELECT "users".* FROM "users" INNER JOIN "relationships" ON "users"."id" = "relationships"."followee_id" WHERE "relationships"."follower_id" = :follower_id) AS "followee_user" INNER JOIN "tweets" ON "followee_user"."id" = "tweets"."user_id" WHERE "tweets"."id" > :tweets_id', param])
  end
end

class OtherTweet < ActiveRecord::Base
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
    # User.find_by_sql([query, param])
    User.find_by_sql([ %|
      SELECT * FROM (
      SELECT tweets.*, users.email as tweeted_email, NULL AS retweeted_email, users.account AS tweeted_account, NULL AS retweeted_account FROM users INNER JOIN tweets ON users.id = tweets.user_id WHERE users.id = :tweet_user_id and "tweets"."id" < :tweets_id
      UNION
      SELECT tweets.*, users.email AS tweeted_email, retweeted_user.email AS retweeted_email, users.account AS tweeted_account, retweeted_user.account AS retweeted_account FROM (SELECT * FROM users INNER JOIN retweets ON users.id = retweets.user_id WHERE users.id = :tweet_user_id) AS retweeted_user INNER JOIN tweets ON retweeted_user.tweet_id = tweets.id INNER JOIN users ON tweets.user_id = users.id WHERE "tweets"."id" < :tweets_id
      ) ORDER BY created_at DESC LIMIT :limit
      |, param ])
  end
end