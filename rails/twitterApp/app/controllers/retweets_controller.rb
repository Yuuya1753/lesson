class RetweetsController < ApplicationController
  before_action :set_retweet, only: [:destroy]
  def create
    @retweet = Retweet.new(retweet_params)

    respond_to do |format|
      if @retweet.save
        format.js
      else
        format.html { render :new }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @retweet.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def retweet_params
    params.require(:retweet).permit(:user_id, :tweet_id)
  end

  def set_retweet
    @retweet = Retweet.find(params[:id])
  end
end
