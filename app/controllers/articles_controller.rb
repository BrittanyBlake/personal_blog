class ArticlesController < ApplicationController
    include ArticlesHelper
    before_action :set_article, only: [:show, :edit, :update, :destroy]


    def index
        @articles = Article.all
    end

    def show
    end

    def new
         @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        @article.user = User.first
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
end
