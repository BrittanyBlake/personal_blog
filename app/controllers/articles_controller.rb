class ArticlesController < ApplicationController
    include ArticlesHelper
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def index
        @articles = Article.all
        @articles = Article.paginate(page: params[:page], per_page: 6)
    end

    def show
    end

    def new
         @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = 'Article successfully saved'
            redirect_to @article
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        @article.update(article_params)
         if @article.save
            flash[:notice] = "Article '#{@article.title}' successfully edited"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to @article
    end

    private
    def set_article
        @article = Article.find(params[:id])
    end

    def require_same_user
        if current_user != @article.user && !current_user.admin?
            flash[:alert] = "You are not authorized to perform this action"
            redirect_to @article
        end
    end
end
