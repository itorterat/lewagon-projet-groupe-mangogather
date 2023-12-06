class BookingsController < ApplicationController
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
    current_user.balance = current_user.balance - @booking.price
    current_user.save!
    if @booking.save
      redirect_to user_path(@user), notice: 'Réservation créée avec succès.'
    else
      render :new, alert: 'Erreur lors de la réservation !'
    end
  end

  def accept
    @booking = Booking.find(params[:id])
    if @booking.update(status: :approved)
      redirect_to dashboard_path, notice: 'La réservation a été acceptée.'
    else
      redirect_to dashboard_path, alert: "Erreur lors de l'acceptation de la réservation."
    end
  end

  def decline
    @booking = Booking.find(params[:id])
    if @booking.update(status: :declined)
      redirect_to dashboard_path, notice: 'La réservation a été refusée.'
    else
      redirect_to dashboard_path, alert: "Erreur lors du refus de la réservation."
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
