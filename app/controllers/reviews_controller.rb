class ReviewsController < ApplicationController
  before_action :set_booking, only: %i[new create]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.author = current_user

    if @booking.approved?
      @review.booking = @booking

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

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
