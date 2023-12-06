class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.author = current_user

    booking = Booking.find_by(id: params[:booking_id])

    if booking.approved?
      @review.booking = booking

      if @review.save
        redirect_to dashboard_path, notice: 'Review créée avec succès.'
      else
        render :new
      end
    else
      redirect_to root_path, alert: 'Impossible de créer une review pour un booking non accepté.'
    end
  end


  private

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
