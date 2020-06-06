class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:index, :show, :new, :create]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] = "You have successfully signed up. Welcome to the blog #{@user.username}!"
            redirect_to articles_path
        else
            render 'new'
        end
    end
    
    def edit
    end

    def update
        @user.update(user_params)
        if @user.save
            flash[:notice] = "You're account has been successfully edited, #{@user.username}."
            redirect_to @user
        else
            render 'edit'
        end
    end

    def show
        @articles = @user.articles
    end

    def index
        @users = User.all
        @users = User.paginate(page: params[:page], per_page: 6)
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Your account and all your artcles have been successfully deleted"
        redirect_to root_path
    end

    private
    def set_user
        @user = User.find(params[:id])
    end
    
    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You are not authorized to perform this action"
            redirect_to @user
        end
    end
end