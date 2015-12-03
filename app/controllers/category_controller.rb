class CategoryController < ApplicationController
  def show
    @category = Category.find params[:id]
      if @category.blank?
          raise 'not exist category'
      else
          # @podcasts = Podcast.all.where category_id: @category.id
          @podcasts = Podcast.includes(:category_podcasts).where(category_podcasts: {category_id: @category.id});
          # @podcasts = Podcast.eager_load(:category_podcast).where("category_id = #{@category.id}")
          render "category/show"
      end
  end
end
