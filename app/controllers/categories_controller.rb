class CategoriesController < ApplicationController
  before_action :set_post, only: [:create]

  def new
    @category = Category.new
  end

  def create
    @add_category = @post.categories.build(category_params)
    @add_category.reload if @add_category.save
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def category_params
    params.require(:category).permit(:topic)
  end
end
