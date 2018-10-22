class UsersController < ApplicationController

  include CurrentUser

  before_action :load_current_user
  before_action :load_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end

    def load_user
      @user = User.find(params[:id])
    end

end
