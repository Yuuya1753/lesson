class HomeController < ApplicationController
  before_action :set_login_user, only: [:index, :follow, :append, :count_tweets, :append_new, :other]
  before_action :set_user, only: [:other]

  def index
  end

  def other
    rel = Relationship.where('follower_id = ? and followee_id = ?', @user.id, @other.id)
    if 0 < rel.size
      @show = true
    else
      @show = false
    end
  end

  def follow
    
  end

  def append
    # @date = params["date"]
    @tweets_id = params["tweets_id"]
    render partial: "append"
  end
  
  def count_tweets
    @tweets_id = params["tweets_id"]
    render partial: "count_tweets"
  end
  
  def append_new
    @limit = params["limit"]
    @tweets_id = params["tweets_id"]
  end

  def download
    tweet_id = params[:id]
    tweet = Tweet.find(tweet_id)
    followee_id = tweet.user_id
    if current_user.nil?
      render :plain => "Access denied. Unauthorized access.", :status => :unauthorizd
    else
      follower_id = current_user.id
      rel = Relationship.where('follower_id = ? and followee_id = ?', follower_id, followee_id)
      if 0 < rel.size
        path = "./" + request.fullpath
        send_file path, :x_sendfile => true
      else
        render :plain => "Access denied. Unauthorized access.", :status => :unauthorizd
      end
    end
  end

  private
  def set_login_user
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      redirect_to '/users/sign_up'
    end
  end

  def set_user
    @other = User.find(params[:id])
  end
end
