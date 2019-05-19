class LikesController < ApplicationController
  before_action :set_likes, only: [:destroy]
  def create
    @likes = Like.new(likes_params)

    respond_to do |format|
      if @likes.save
        format.js
      else
        format.html { render :new }
        format.json { render json: @likes.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @likes.destroy
    respond_to do |format|
      format.js
    end
  end

  private
  def likes_params
    params.require(:like).permit(:user_id, :tweet_id)
  end

  def set_likes
    @likes = Like.find(params[:id])
  end
end
