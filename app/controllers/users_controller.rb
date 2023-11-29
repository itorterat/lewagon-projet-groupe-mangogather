class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @users = User.all
    @users = @users.where(city: params[:city]) if params[:city].present?

    if params[:category].present?
      category = Category.find_by(name: params[:category])
      @users = @users.joins(:services).where(services: { category_id: category.id }) if category
    end

    @users = @users.distinct
  end

  def show
    @user = User.find(params[:id])
  end
end
