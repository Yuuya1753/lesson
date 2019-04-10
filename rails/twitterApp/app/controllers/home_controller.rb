class HomeController < ApplicationController
  before_action :set_login_user, only: [:index, :follow, :append]
  before_action :set_user, only: [:other]

  def index
  end

  def other
  end

  def follow
    
  end

  def append
    @date = params["date"]
    render partial: "append"
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
    @user = User.find(params[:id])
  end
end
