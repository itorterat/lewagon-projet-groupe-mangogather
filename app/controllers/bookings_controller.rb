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
    @booking.author = current_user
    @user = User.find(params[:user_id])

    if @booking.save
      redirect_to user_path(@user), notice: 'Réservation créée avec succès.'
    else
      render :new, notice: 'Erreur lors de la réservation !'
    end
  end

  def accept
    @booking = Booking.find(params[:id])
    if @booking.update(status: :approved)
      redirect_to dashboard_path, notice: 'Réservation a été acceptée avec succès.'
    else
      redirect_to dashboard_path, alert: "Erreur lors de l'acceptation de la réservation."
    end
  end

  def decline
    @booking = Booking.find(params[:id])
    if @booking.update(status: :declined)
      redirect_to dashboard_path, notice: 'Réservation a été refusée avec succès.'
    else
      redirect_to dashboard_path, alert: "Erreur lors du refus de la réservation."
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:difficulty, :status, :date, :price, :service_id)
  end
end
