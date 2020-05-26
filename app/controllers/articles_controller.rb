class ArticlesController < ApplicationController
    include ArticlesHelper

    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
         @article = Article.new
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            flash[:notice] = 'Article successfully saved'
            redirect_to @article
        else
            render 'new'
        end
    end
end
