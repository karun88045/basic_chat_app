module Session
  class SessionsController < ApplicationController

    def new
      @user = User.new
    end

    def create
      @user = User.find_by(email: params[:email])
      if user && user.password_valid(params[:password])
        session(:user) = user
        redirect_to root_path
      end
    end

    def destroy
    end

    private 

    def session_params
      
    end
  end
end
