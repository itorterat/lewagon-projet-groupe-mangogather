class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home search]

  def home; end

  def dashboard
    @authored_bookings = current_user.bookings.order(created_at: :desc)
    @bookings = Booking.where(service: current_user.services).order(created_at: :desc)
  end

  def search
    @users = User.all

    if params[:category].present?
      category = Category.find_by(name: params[:category])
      @users = @users.joins(:services).where(services: { category_id: category.id }) if category
    end
    redirect_to users_path(city: params[:city].capitalize, category: params[:category])
  end
end
