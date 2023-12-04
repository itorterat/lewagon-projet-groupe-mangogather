class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_user, only: %i[edit_profile update_profile]

  def index
    @users = User.all
    @users_count = {}

    if params[:category].present?
      category = Category.find_by(name: params[:category])
      @users = @users.joins(:services).where(services: { category_id: category.id }) if category
    end

    if params[:city].present?
      @users = @users.where(city: params[:city])
    else
      @users_count = @users.group_by { |user| user.city }.transform_values(&:count)
      @users = @users.where(city: @users_count.keys)
    end

      @markers = @users.geocoded.map do |user|
        {
          lat: user.latitude,
          lng: user.longitude,
          info_window: render_to_string(partial: "info_window", locals: { user: user }),
          marker_html: render_to_string(partial: "marker")
        }
      end
    @users = @users.distinct
  end

  def show
    @booking = Booking.new
    @user = User.find(params[:id])
    @users_count = {}
    @markers = [{
      lat: @user.latitude,
      lng: @user.longitude,
      info_window: render_to_string(partial: "info_window", locals: { user: @user }),
      marker_html: render_to_string(partial: "marker")
    }]
  end


  def edit_profile
    @categories = Category.all.order(:name)
  end

  def update_profile
    if @user.update(user_params)
      redirect_to edit_profile_path, notice: 'Profil mis à jour avec succès.'
    else
      @categories = Category.all.order(:name)
      render :edit_profile
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :city, :description, category_ids: [])
  end
end
