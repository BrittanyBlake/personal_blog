class UsersController < ApplicationController

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = "You have successfully signed up. Welcome to the blog #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        if @user.save
            flash[:notice] = "You're account has been successfully edited, #{@user.username}."
            redirect_to @user
        else
            render 'edit'
        end
    end

    def show
        @user = User.find(params[:id])
        @articles = @user.articles
   
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end