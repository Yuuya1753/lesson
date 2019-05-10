class RetweetsController < ApplicationController
  def create
    @retweet = Retweet.new(retweet_params)

    respond_to do |format|
      if @retweet.save
        format.html { redirect_to @retweet, notice: 'retweet was successfully created.' }
        format.json { render :show, status: :created, location: @retweet }
      else
        format.html { render :new }
        format.json { render json: @retweet.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def retweet_params
    params.require(:retweet).permit(:user_id, :tweet_id)
  end
end
