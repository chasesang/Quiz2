class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy, :update]
  def create
    @idea = Idea.find(params[:idea_id])
    review_params = params.require(:review).permit(:body)
    @review = Review.new(review_params)
    @review.idea = @idea
    @review.user = current_user

    if @review.save
      redirect_to idea_path(@idea), notice: 'Review Created!'
    else
      render '/ideas/show'
    end
  end

  def destroy
    review = Review.find(params[:id])
    if !(can? :destroy, review)
      redirect_to idea_path(review.idea), alert: 'access denied!'
    else
      review.destroy
      redirect_to idea_path(review.idea), notice: 'Review deleted!'
    end
  end


end
