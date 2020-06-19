class CategoriesController < ApplicationController
    def new
        @category = Category.new
    end

    def create
        @category = Category.new(category_params)
        if @category.save
            flash[:notice] = "Category successfully created"
            redirect_to @category
        else
            render 'new'
        end
    end

    def show
    end

    def index
    end

    private
    def category_params
        params.require(:category).permit(:name)
    end
end