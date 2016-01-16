class ReviewsController < RankingController
  def new
    @review = Review.new
    @product = Product.find(params[:product_id])
  end
end
