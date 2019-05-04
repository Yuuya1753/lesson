class HomeController < ApplicationController
  before_action :set_login_user, only: [:index, :follow, :append, :count_tweets, :append_new, :other, :follower_list, :followee_list]
  before_action :set_user, only: [:other]

  def index
    @follower_rels = Relationship.where('follower_id = ? and followee_id != ?', @user.id, @user.id)
    @followee_rels = Relationship.where('follower_id != ? and followee_id = ?', @user.id, @user.id)
  end

  def other
    if @other.private
      rel = Relationship.where('follower_id = ? and followee_id = ?', @user.id, @other.id)
      if 0 < rel.size
        @show = true
      else
        @show = false
      end
    else
      @show = true
    end
  end

  def follow
    
  end

  def follower_list
    @followers = []
    rels = Relationship.where('follower_id = ?', @user.id)
    rels.each { |rel|
      @followers.push(User.find(rel.followee_id))
    }
  end

  def followee_list
    @followees = []
    rels = Relationship.where('followee_id = ?', @user.id)
    rels.each { |rel|
      @followees.push(User.find(rel.follower_id))
    }
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

  def download_icon
    if current_user.nil?
      render :plain => "Access denied. Unauthorized access.", :status => :unauthorizd
    else
      path = "./" + request.fullpath
      send_file path, :x_sendfile => true
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
    if params[:account].nil?
      @other = User.find(params[:id])
    else
      @other = User.find_by_account(params[:account])
    end
  end
end
