class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
    @user = current_user
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @user = User.find(params[:user_id])
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)
    tip = @booking.tip
    @booking.author = current_user
    @booking.price = calculate_coefficient(@booking.difficulty) + tip
    @user = User.find(params[:user_id])

    if @booking.save
      redirect_to user_path(@user), notice: 'Réservation créée avec succès.'
    else
      render :new, notice: 'Erreur lors de la réservation !'
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:difficulty, :status, :date, :price, :service_id, :tip)
  end

  def calculate_coefficient(difficulty)
    case difficulty
    when 'easy'
      @booking.service.category.price * 0.75
    when 'normal'
      @booking.service.category.price * 1
    when 'hard'
      @booking.service.category.price * 1.5
    end
  end
end
