class UsersController < ApplicationController
    before_filter :authorize, only: [:edit, :update]
    before_filter :user, only: [:show, :edit, :update, :destroy]

    def index

    end

    def show
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_url, notice: "Thank you for signing up!"
        else
            render "new"
        end
    end

    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation)
        end

        def user
          @user = User.find_by_slug!(params[:id])
        end
        helper_method :user
end
