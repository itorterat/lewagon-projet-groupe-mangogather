class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @user = current_user
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id]) if params[:user_id].present?
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.author = current_user
    @user = User.find(params[:id])
    if @booking.save
      redirect_to user_path(current_user), notice: 'Booking was successfully created.'
    else
      render :new
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :difficulty, :status, :price)
  end
end
