class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def create
    # @user.create!(user_params)
    # redirect_to users_path
    # debugger
  end

  def new
    # @user = User.new
  end

  def show
  end

  def edit
  end

  def logout
  end

  private 

  def user_params
    params.require(:message).permit(:body,:user_id)
  end
end
